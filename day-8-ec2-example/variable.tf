variable "subnet_id" {
  description = ""
  type        = string
  default     = "subnet-0d65714ab71cd79da"
}
variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = string
  default     = "sg-074fed351d1ac450b"
}