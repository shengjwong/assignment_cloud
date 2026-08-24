variable "name_prefix" {
  description = "Prefix applied to all resource names in this module."
  type        = string
  default     = "vendor-booking-app"
}

variable "bucket_name" {
  description = "Globally-unique S3 bucket name for uploaded vendor images."
  type        = string
  default     = "vendor-app-assets-2026-group3"
}

variable "public_read_prefix" {
  description = "Object key prefix (glob) that is publicly readable, e.g. uploads/*."
  type        = string
  default     = "uploads/*"
}