variable "cidr_block_vpc" {
    description = "vpc-cidr"
    type = string
    default = ""
}
variable "cidr_block_pub_sub" {
    description = "pub_sub_cidr"
    type = string
    default = ""
  
}
variable "cidr_block_pv_sub" {
    description = "pv_sub_cidr"
    type = string
    default = ""
}
variable "ami_id1" {
    description = "ami_id"
    type = string 
    default = ""
}
variable "ami_id2" {
     description = "ami_id"
    type = string 
    default = ""

}
variable "type1" {
    description = "type"
    type = string 
    default = ""
   
}
variable "type2" {
    description = "type"
    type = string 
    default = ""
   
}
     