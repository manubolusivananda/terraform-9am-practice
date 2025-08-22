variable "cidr_block_vpc" {
    description = "vpc-cidr"
    type = string
    default = ""
}
variable "cidr_block_pub_sub" {
    description = "pub-sub-cidr"
    type = string
    default = ""
  
}
variable "cidr_block_pvt_1" {
    description = "pvt-sub1-cidr"
    type = string
    default = ""
}
variable "cidr_block_pvt_2" {
     description = "pvt-sub2-cidr"
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