/**
  * <!-- Module variables go here.
  *      Always include descriptions as they will populate
  *      autogenerated documentation. -->
*/


variable "name" {
  type        = string
  description = <<-EOT
      The name of the ALB.
      This value is used as the basis for naming various other resources.
    EOT
}

variable "vpc_id" {
  description = <<-EOT
    ID of VPC.
  EOT
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = <<-EOT
    Subnets to deploy Load Balancer in.
  EOT
}

variable "domain_name" {
  description = <<-EOT
        DNS domain.
        This will be combined with application_host to form the fqdn.
        This should already exist as a route53 hosted domain.
    EOT
  type        = string
}

variable "application_host" {
  description = <<-EOT
        Hostname where the application will be reachable.
    EOT
  type        = string
}

variable "waf_log_retention_days" {
  description = <<-EOT
    Number of days to retain WAF logs
  EOT
  type        = number
  default     = 90
}

variable "enable_waf" {
  description = <<-EOT
    Enable or disable WAF.
  EOT
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = <<-EOT
    The time in seconds that the connection is allowed to be idle.
  EOT
  type        = number
  default     = 600
}

variable "log_bucket" {
  type        = string
  description = <<-EOT
    S3 bucket to store logs.
  EOT
}

variable "waf_managed_rules" {
  type = map(object({
    rule_action_overrides = optional(map(string), {})
  }))
  description = <<-EOT
    List of WAF managed rules.
  EOT
  default = {
    AWSManagedRulesPHPRuleSet             = {}
    AWSManagedRulesAmazonIpReputationList = {}
    AWSManagedRulesAnonymousIpList        = {}
    AWSManagedRulesCommonRuleSet = {
      rule_action_overrides = {
        SizeRestrictions_BODY = "allow"
      }
    }
    AWSManagedRulesKnownBadInputsRuleSet = {}
    AWSManagedRulesLinuxRuleSet          = {}
    AWSManagedRulesSQLiRuleSet           = {}
  }
}
