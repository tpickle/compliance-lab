# Region for all resources (can be overridden by TF_VAR_region env var)
variable "region" {
  type    = string
  default = "us-east-1"
}

# Instance size; small but realistic for demos
variable "instance_type" {
  type    = string
  default = "t3.small"
}

# Ubuntu LTS AMI ID for your region; set via tfvars or env if you prefer
# You can later replace this with a data source lookup for automation.
variable "ami_id" {
  type        = string
  description = "Ubuntu LTS AMI ID"
}