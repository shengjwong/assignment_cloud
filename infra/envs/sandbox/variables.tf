variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix applied to every resource name."
  type        = string
  default     = "vendor-booking-app"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones to spread subnets across."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type for app servers."
  type        = string
  default     = "t3.micro"
}

variable "instance_profile_name" {
  description = "Existing AWS Academy IAM instance profile."
  type        = string
  default     = "LabInstanceProfile"
}

variable "db_name" {
  type    = string
  default = "vendor_db"
}

variable "db_username" {
  type    = string
  default = "vendor_admin"
}

variable "secret_name" {
  type    = string
  default = "vendor-db-credentials"
}

variable "s3_bucket_name" {
  description = "Globally-unique bucket name for event image uploads."
  type        = string
  default     = "vendor-app-assets-2026-group3"
}

variable "artifact_key" {
  description = "S3 object key that deploy.yml uploads the app release artifact to."
  type        = string
  default     = "artifacts/vendor-app.zip"
}

variable "health_check_path" {
  type    = string
  default = "/healthz.php"
}

variable "asg_min_size" {
  type    = number
  default = 2
}

variable "asg_max_size" {
  type    = number
  default = 4
}

variable "asg_desired_capacity" {
  type    = number
  default = 2
}