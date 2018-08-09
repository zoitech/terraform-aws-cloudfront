variable "dns_domain_name" {
  description = "(Required) - The DNS domain name of either the S3 bucket, or web site of your custom origin."
}

variable "origin_path" {
  description = "(Optional) - An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin."
  default     = ""
}

variable "origin_id" {
  description = "(Required) - A unique identifier for the origin."
}

variable "state_enabled" {
  description = "(Required) - Whether the distribution is enabled to accept end user requests for content."
  default     = true
}

variable "is_ipv6_enabled" {
  description = "(Optional) - Whether the IPv6 is enabled for the distribution."
  default     = false
}

variable "comment" {
  description = "(Optional) - Any comments you want to include about the distribution."
}

variable "default_root_object" {
  description = "(Optional) - The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  default     = "index.html"
}

variable "logging_config_include_cookies" {
  description = "(Optional) - Specifies whether you want CloudFront to include cookies in access logs (default: false)."
  default     = false
}

variable "logging_config_bucket" {
  description = "(Required) - The Amazon S3 bucket to store the access logs in, for example, myawslogbucket.s3.amazonaws.com."
}

variable "logging_config_prefix" {
  description = "(Optional) - An optional string that you want CloudFront to prefix to the access log filenames for this distribution, for example, myprefix/."
}

variable "aliases" {
  type        = "list"
  description = "(Optional) - Extra CNAMEs (alternate domain names), if any, for this distribution."
}

variable "default_cache_behavior_allowed_methods" {
  type        = "list"
  description = "(Required) - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
}

variable "default_cache_behavior_cached_methods" {
  type        = "list"
  description = "(Required) - Controls whether CloudFront caches the response to requests using the specified HTTP methods."
}

variable "target_origin_id" {
  description = "(Required) - The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior."
}

variable "viewer_protocol_policy" {
  description = "(Required) - Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
}

variable "price_class" {
  description = "(Optional) - The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
}

variable "restriction_type" {
  description = "(Required) - The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  default     = "none"
}

variable "restriction_locations" {
  type        = "list"
  description = "(Optional) - The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
  default     = []
}

variable "acm_certificate_arn" {
  description = "The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. Specify this, cloudfront_default_certificate, or iam_certificate_id. The ACM certificate must be in US-EAST-1."
}

variable "minimum_protocol_version" {
 description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. One of SSLv3, TLSv1, TLSv1_2016, TLSv1.1_2016 or TLSv1.2_2018. Default: TLSv1. NOTE: If you are using a custom certificate (specified with acm_certificate_arn or iam_certificate_id), and have specified sni-only in ssl_support_method, TLSv1 or later must be specified. If you have specified vip in ssl_support_method, only SSLv3 or TLSv1 can be specified. If you have specified cloudfront_default_certificate, TLSv1 must be specified."
} 
variable "ssl_support_method" {
 description = "Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only. Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges."
} 
