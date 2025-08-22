variable "cidr_block_vpc" {
    description = "vpc-cidr"
    type = string
    default = ""
}
variable "ami_id" {
    description = "ami-id"
    type = string
    default = ""
  
}
variable "instance_type" {
    type = string
    default = ""
  
}
variable "identifier" {
    description = "value"
    type = string
    default = ""
  
}

variable "allocated_storage" {
  description = "value"
  type = string
  default = ""
}
variable "engine" {
    description = "value"
    type = string
    default = ""
  
}
variable "engine_version" {
    description = "value"
    type = string
    default = ""
  
}
variable "instance_class" {
    description = "value"
    type = string
    default = ""
}
variable "username" {
    description = "value"
    type = string
    default = ""
  
}
variable "password" {
    description = "value"
    type = string
    default = ""  
}


variable "skip_final_snapshot" {
    description = "value"
    type = string
    default = ""
  
}

variable "publicly_accessible" {
    description = "value"
    type = string
    default = ""
}
variable "backup_retention_period" {
    description = "value"
    type = string
    default = ""
  
}