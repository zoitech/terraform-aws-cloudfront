# AWS Application Load Balancer Module
Terraform module which sets up a CloudFront distribution with logging into S3.

The following resources are created:
* CloudFront


## Usage
### Specify this Module as Source
```hcl
module "my_cloudfront" {
  source = "git::https://github.com/zoitech/terraform-aws-cloudfront.git"

  # Or to specifiy a particular module version:
  source = "git::https://github.com/zoitech/terraform-aws-cloudfront.git?ref=2.1.0"
```
### Usage Example
```
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
  default_cache_behavior_forwarded_values_headers = ["origin"]
  target_origin_id                       = "s3-my-origin-id"
  viewer_protocol_policy                 = "redirect-to-https"
  price_class                            = "PriceClass_100"

  # Custom Error Response
  custom_error_response = [
    {
    error_caching_min_ttl = "86400"          #Optional
    error_code            = "404"            #Required
    response_code         = "200"            #Optional
    response_page_path    = "/index.html"}   #Optional
  ]
  
  # Geo Restrictions
  restriction_type = "none"

  # Certificate
  acm_certificate_arn      = data.aws_acm_certificate.my_acm_certificate.arn
  minimum_protocol_version = "TLSv1.1_2016"
  ssl_support_method       = "sni-only"
}
```

#### Outputs
The following outputs are possible:
* domain_name  (The domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net)
* hosted_zone_id (The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2.)
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. Specify this, cloudfront\_default\_certificate, or iam\_certificate\_id. The ACM certificate must be in US-EAST-1. | `any` | n/a | yes |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | (Optional) - Extra CNAMEs (alternate domain names), if any, for this distribution. | `list(string)` | n/a | yes |
| <a name="input_comment"></a> [comment](#input\_comment) | (Optional) - Any comments you want to include about the distribution. | `any` | n/a | yes |
| <a name="input_custom_error_response"></a> [custom\_error\_response](#input\_custom\_error\_response) | (Optional) - One or more custom error response elements (multiples allowed). | `any` | `[]` | no |
| <a name="input_default_cache_behavior_allowed_methods"></a> [default\_cache\_behavior\_allowed\_methods](#input\_default\_cache\_behavior\_allowed\_methods) | (Required) - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. | `list(string)` | n/a | yes |
| <a name="input_default_cache_behavior_cached_methods"></a> [default\_cache\_behavior\_cached\_methods](#input\_default\_cache\_behavior\_cached\_methods) | (Required) - Controls whether CloudFront caches the response to requests using the specified HTTP methods. | `list(string)` | n/a | yes |
| <a name="input_default_cache_behavior_forwarded_values_headers"></a> [default\_cache\_behavior\_forwarded\_values\_headers](#input\_default\_cache\_behavior\_forwarded\_values\_headers) | (Required) - Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers. | `list(string)` | n/a | yes |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | (Optional) - The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. | `string` | `"index.html"` | no |
| <a name="input_dns_domain_name"></a> [dns\_domain\_name](#input\_dns\_domain\_name) | (Required) - The DNS domain name of either the S3 bucket, or web site of your custom origin. | `any` | n/a | yes |
| <a name="input_is_ipv6_enabled"></a> [is\_ipv6\_enabled](#input\_is\_ipv6\_enabled) | (Optional) - Whether the IPv6 is enabled for the distribution. | `bool` | `false` | no |
| <a name="input_logging_config_bucket"></a> [logging\_config\_bucket](#input\_logging\_config\_bucket) | (Required) - The Amazon S3 bucket to store the access logs in, for example, myawslogbucket.s3.amazonaws.com. | `any` | n/a | yes |
| <a name="input_logging_config_include_cookies"></a> [logging\_config\_include\_cookies](#input\_logging\_config\_include\_cookies) | (Optional) - Specifies whether you want CloudFront to include cookies in access logs (default: false). | `bool` | `false` | no |
| <a name="input_logging_config_prefix"></a> [logging\_config\_prefix](#input\_logging\_config\_prefix) | (Optional) - An optional string that you want CloudFront to prefix to the access log filenames for this distribution, for example, myprefix/. | `any` | n/a | yes |
| <a name="input_minimum_protocol_version"></a> [minimum\_protocol\_version](#input\_minimum\_protocol\_version) | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. One of SSLv3, TLSv1, TLSv1\_2016, TLSv1.1\_2016 or TLSv1.2\_2018. Default: TLSv1. NOTE: If you are using a custom certificate (specified with acm\_certificate\_arn or iam\_certificate\_id), and have specified sni-only in ssl\_support\_method, TLSv1 or later must be specified. If you have specified vip in ssl\_support\_method, only SSLv3 or TLSv1 can be specified. If you have specified cloudfront\_default\_certificate, TLSv1 must be specified. | `any` | n/a | yes |
| <a name="input_origin_id"></a> [origin\_id](#input\_origin\_id) | (Required) - A unique identifier for the origin. | `any` | n/a | yes |
| <a name="input_origin_path"></a> [origin\_path](#input\_origin\_path) | (Optional) - An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. | `string` | `""` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | (Optional) - The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100 | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | region | `string` | `"eu-west-1"` | no |
| <a name="input_restriction_locations"></a> [restriction\_locations](#input\_restriction\_locations) | (Optional) - The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). | `list(string)` | `[]` | no |
| <a name="input_restriction_type"></a> [restriction\_type](#input\_restriction\_type) | (Required) - The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist. | `string` | `"none"` | no |
| <a name="input_ssl_support_method"></a> [ssl\_support\_method](#input\_ssl\_support\_method) | Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only. Required if you specify acm\_certificate\_arn or iam\_certificate\_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges. | `any` | n/a | yes |
| <a name="input_state_enabled"></a> [state\_enabled](#input\_state\_enabled) | (Required) - Whether the distribution is enabled to accept end user requests for content. | `bool` | `true` | no |
| <a name="input_target_origin_id"></a> [target\_origin\_id](#input\_target\_origin\_id) | (Required) - The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior. | `any` | n/a | yes |
| <a name="input_viewer_protocol_policy"></a> [viewer\_protocol\_policy](#input\_viewer\_protocol\_policy) | (Required) - Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | n/a |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | n/a |
