// nosignal.io and www.nosignal.io

resource "aws_s3_bucket" "nosignal" {
  bucket  = "nosignal.io"
  acl     = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "www" {
  bucket  = "www.nosignal.io"
  acl     = "public-read"

  website {
    redirect_all_requests_to = "https://nosignal.io"
  }
}

resource "aws_route53_record" "apex" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = aws_s3_bucket.nosignal.bucket
  type    = "A"

  alias {
    zone_id                 = "Z2FDTNDATAQYW2"
    name                    = "d37nuqwyj5gsod.cloudfront.net"
    evaluate_target_health  = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = aws_s3_bucket.www.bucket
  type    = "A"

  alias {
    zone_id                 = "Z2FDTNDATAQYW2"
    name                    = "d3po4hpjy2hac3.cloudfront.net"
    evaluate_target_health  = false
  }
}

// certificate validation - certificate manager
resource "aws_route53_record" "cert-apex" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = "_c1b6bfeed6c0034bb3d466775ece570f.nosignal.io"
  type    = "CNAME"
  ttl     = 300
  records = [
    "_10c42d55722284b92db7c525a1699ca7.vhzmpjdqfx.acm-validations.aws"
  ]
}

resource "aws_route53_record" "cert-www" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = "_24ce601e2f840cbd713b6256d349933b.www.nosignal.io"
  type    = "CNAME"
  ttl     = 300
  records = [
    "_a59ceb344c9658b99e0d6a67e1a87ea9.vhzmpjdqfx.acm-validations.aws"
  ]
}
