// Base Route53 records for nosignal.io.

resource "aws_route53_zone" "nosignal" {
  name = "nosignal.io"
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = "nosignal.io"
  type    = "MX"
  ttl     = 300
  records = [
    "10 mail.protonmail.ch",
    "20 mailsec.protonmail.ch"
  ]
}

resource "aws_route53_record" "ns" {
  allow_overwrite = true
  name            = "nosignal.io"
  ttl             = 30
  type            = "NS"
  zone_id         = aws_route53_zone.nosignal.zone_id

  records = [
    aws_route53_zone.nosignal.name_servers.0,
    aws_route53_zone.nosignal.name_servers.1,
    aws_route53_zone.nosignal.name_servers.2,
    aws_route53_zone.nosignal.name_servers.3,
  ]
}

resource "aws_route53_record" "root_txt" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = "nosignal.io"
  type    = "TXT"
  ttl     = 300
  records = [
    "protonmail-verification=b747cfff58af0cc2ca9ef9f24f2757afa86213b7",
    "v=spf1",
    "include:_spf.protonmail.ch",
    "mx",
    "~all",
  ]
}

resource "aws_route53_record" "dmarc" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = "_dmarc.nosignal.io"
  type    = "TXT"
  ttl     = 300
  records = [
    "v=DMARC1"
  ]
}

resource "aws_route53_record" "domainkey" {
  zone_id = aws_route53_zone.nosignal.zone_id
  name    = "protonmail._domainkey.nosignal.io"
  type    = "TXT"
  ttl     = 300
  records = [
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDK65t9Tc0KdZv3VgsoBQnd8V5k0APUrSUxFxiD1TxR6wXzxNTRmGzQgSM1PC1HlVO87nHkWkiWMXLTrBZndy8cA2fO1HihWDKCeuOk7YGO51x4boEGtghnzB2feowW1drb9DhUdpPh3xjP7pEqqSuQQAuuFpC8GuAbUcu6ShNzsQIDAQAB"
  ]
}
