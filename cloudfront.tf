resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = "${var.dns_domain_name}"
    origin_id   = "${var.origin_id}"

    s3_origin_config {
      origin_access_identity = "${var.origin_access_identity}"
    }
  }

  enabled             = "${var.state_enabled}"
  is_ipv6_enabled     = "${var.is_ipv6_enabled}"
  comment             = "${var.comment}"
  default_root_object = "${var.default_root_object}"

  logging_config {
    include_cookies = "${var.logging_config_include_cookies}" #The logging configuration that controls how logs are written to your distribution (maximum one).
    bucket          = "${var.logging_config_bucket}"
    prefix          = "${var.logging_config_prefix}"
  }
 
  aliases = "${var.aliases}" #list

  # Custom Error response
  custom_error_response = ["${var.custom_error_response}" ] #list
  
  default_cache_behavior {
    allowed_methods  = "${var.default_cache_behavior_allowed_methods}" #list
    cached_methods   = "${var.default_cache_behavior_cached_methods}"  #list
    target_origin_id = "${var.target_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }

      headers = "${var.default_cache_behavior_forwarded_values_headers}" #list
    }

    viewer_protocol_policy = "${var.viewer_protocol_policy}"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "${var.price_class}"

  restrictions {
    geo_restriction {
      restriction_type = "${var.restriction_type}"
      locations        = "${var.restriction_locations}"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.acm_certificate_arn}"
    minimum_protocol_version = "${var.minimum_protocol_version}"
    ssl_support_method = "${var.ssl_support_method}"
  }
}
