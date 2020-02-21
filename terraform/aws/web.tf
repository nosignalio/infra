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

resource "aws_route53_record" "apex" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = aws_s3_bucket.nosignal.bucket
  type    = "A"

  alias {
    zone_id                 = aws_s3_bucket.nosignal.hosted_zone_id
    name                    = aws_s3_bucket.nosignal.website_endpoint
    evaluate_target_health  = false
  }
}

resource "aws_s3_bucket" "www" {
  bucket  = "www.nosignal.io"
  acl     = "public-read"

  website {
    redirect_all_requests_to = "https://nosignal.io"
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = aws_s3_bucket.www.bucket
  type    = "CNAME"

  alias {
    zone_id                 = aws_s3_bucket.www.hosted_zone_id
    name                    = aws_s3_bucket.www.website_endpoint
    evaluate_target_health  = false
  }
}
