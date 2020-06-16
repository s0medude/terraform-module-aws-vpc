variable "create_vpc" {
    description = "Controls if VPC should br created"
    type        = bool
    default     = true  
}

variable "name" {
    description = "Name to be assigned on all resources as indentifier"
    type        = string
    default     = ""
}

variable "cidr_block_vpc" { 
    description = "The CIDR block for the VPC. The default CIDR block is '0.0.0.0/0' and  it should be replace for a valid CIDR block"
    type        = string
    default     = "0.0.0.0/0" 
}

variable "enable_ipv6" {
    description = "Request if an IPV6 CIDR block should be provising"
    type        = bool
    default     = false  
}

variable "instance_tenancy" {
    description = "A tenacy option for instances launched into the VPC"
    type        = string
    default     = "default"  
}

variable "public_subnet_suffix" {
    description = "Suffix to append to public subnets name"
    type        = string
    default     = "public"
}

variable "private_subnet_suffix" {
    description = "Suffix to append to private subnets name"
    type        = string
    default     = "private"
}

variable "public_subnets" {
    description = "A list of the public subnets inside the VPC"
    type        = list(string)
    default     = []
}

variable "private_subnets" {
    description = "A list of the private subnets inside the VPC"
    type        = list(string)
    default     = []
}

variable "azs" {
    description = "A list of availability zones in the region"
    type        = list(string)
    default     = []
}

variable "enable_dns_hostnames" {
    description = "Should be true to enable DNS hostnames in the VPC"
    type        = bool
    default     = false
}

variable "enable_dns_support" {
    description = "Should be true to enable DNS support in the VPC"
    type        = bool
    default     = true
}

variable "enable_classiclink" {
    description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
    type        = bool
    default     = true  
}

variable "enable_classiclink_dns_support" {
  description = "Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = null
}

variable "enable_nat_instance" {
    description = "Controls if a NAT instance should be created"
    type        = bool
    default     = false
}

variable "single_nat_instance" {
    description = "Should be true if you want to provision a single shared NAT Instance across all of your private networks"
    type        = bool
    default     = false
}

variable "one_nat_instance_per_az" {
  description = "Should be true if you want only one NAT Instance per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
  default     = false
}

variable "nat_instance_type" {
    description = "Type os the NAt instance to provide internet for the private subnets"
    type        = string
    default     = "t2.micro"  
}

variable "map_public_ip_on_launch" {
    description = "Should be false if you do not want to auto-assign public IP on launch"
    type        = bool
    default     = true
}

variable "reuse_nat_ips" {
    description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
    type        = bool
    default     = false
}

variable "external_nat_ip_ids" {
    description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
    type        = list(string)
    default     = []
}

variable "source_dest_check" {
    description = "Should be true if you want that traffic is routed to the instance when the destination address does not match the instance."
    type        = bool
    default     = false  
}

variable "associate_public_ip_address" {
    description = "Default value is true, but you should change it to false if you want that your instance doen´t have a public ip"
    type        = bool
    default     = true  
}

variable "tags" {
    description = "A map of tags to add to all resources"
    type        = map(string)
    default     = {}
}

variable "vpc_tags" {
    description = "Additional tags for the VPC"
    type        = map(string)
    default     = {}
}

variable "igw_tags" {
    description = "Additional tags for the Internet Gateway"
    type        = map(string)
    default     = {}  
}

variable "public_route_table_tags" {
    description = "Additional tags for the public route tables"
    type        = map(string)
    default     = {}  
}

variable "private_route_table_tags" {
    description = "Additional tags for the private route tables"
    type        = map(string)
    default     = {}  
}

variable "public_subnet_tags" {
    description = "Additional tags for the public subnets"
    type        = map(string)
    default     = {}  
}

variable "private_subnet_tags" {
    description = "Additional tags for the private subnets"
    type        = map(string)
    default     = {}  
}

variable "nat_eip_tags" {
    description = "Additional tags for the NAT EIP"
    type        = map(string)
    default     = {}   
}

variable "nat_instance_tags" {
    description = "Additional tags for the NAT INSTANCE"
    type        = map(string)
    default     = {}   
}

variable "sg_tags" {
    description = "Additional tags for the NAT INSTANCE security group"
    type        = map(string)
    default     = {}   
}