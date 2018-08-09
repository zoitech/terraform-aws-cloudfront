# AWS Application Load Balancer Module
Terraform module which sets up a CloudFront distribution with logging into S3.

The following resources are created:
* CloudFront


## Usage
### Specify this Module as Source
```hcl
module "alb" {
  source = "git::https://github.com/zoitech/terraform-aws-cloudfront.git"

  # Or to specifiy a particular module version:
  source = "git::https://github.com/zoitech/terraform-aws-cloudfront.git?ref=v0.0.1"
```
### Usage Example
module "my_cloudfront" {
  source          = "git::https://github.com/zoitech/terraform-aws-cloudfront.git"
  dns_domain_name = "mydomain.s3.amazonaws.com"
  origin_path     = "/mypath"
  origin_id       = "s3-myorigin"

  #s3_origin_config - origin_access_identity
  state_enabled       = true
  is_ipv6_enabled     = false
  comment             = "Environment=Prod"
  default_root_object = "index.html"

  # Logging into S3
  logging_config_include_cookies = false
  logging_config_bucket          = "mylogbucket.s3.amazonaws.com"
  logging_config_prefix          = "s3-my-origin-id"

  # Aliases 
  aliases = ["myalias.mywebsite.com"]

  # Default Cache Behavior Settings
  default_cache_behavior_allowed_methods = ["GET", "HEAD"]
  default_cache_behavior_cached_methods  = ["GET", "HEAD"]
  target_origin_id                       = "s3-my-origin-id"
  viewer_protocol_policy                 = "redirect-to-https"
  price_class                            = "PriceClass_100"

  # Geo Restrictions
  restriction_type = "none"

  # Certificate
  acm_certificate_arn      = "${data.aws_acm_certificate.my_acm_certificate.arn}"
  minimum_protocol_version = "TLSv1.1_2016"
  ssl_support_method       = "sni-only"
}

