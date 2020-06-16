output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.vpc.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.vpc.*.arn, [""])[0]
}

output "vpc_cidr_block" {
  description = "The CIDR Block of the VPC"
  value       = concat(aws_vpc.vpc.*.cidr_block, [""])[0]
}

output "private_subnets_list" {
  description = "List od the subnets ID"
  value       = aws_subnet.private.*.id
}

output "private_subnets_cidr_block" {
  description = "List od the subnets ID"
  value       = aws_subnet.private.*.cidr_block
}

output "public_subnets_list" {
  description = "List od the subnets ID"
  value       = aws_subnet.public.*.id
}

output "public_subnets_cidr_block" {
  description = "List od the subnets ID"
  value       = aws_subnet.public.*.cidr_block
}

output "internet_gateway_id" {
  description = "The id of the internet gateway recently created"
  value       = concat(aws_internet_gateway.igw.*.id, [""])[0]
}

output "eip_id" {
  description = "The id of eip resource"
  value       = concat(aws_eip.nat.*.id, [""])[0]
}

output "eip_private_ip" {
  description = "The public ip address"
  value       = concat(aws_eip.nat.*.private_ip, [""])[0]
}

output "eip_public_ip" {
  description = "The public ip address"
  value       = concat(aws_eip.nat.*.public_ip, [""])[0]
}

output "eip_instance" {
  description = "Contains the id of the attached instance"
  value       = concat(aws_eip.nat.*.instance, [""])[0]
}

output "nat_instance_id" {
  description = "The instance id"
  value       = concat(aws_instance.nat.*.id, [""])[0]
}

output "nat_instance_arn" {
  description = "The instance arn"
  value       = concat(aws_instance.nat.*.arn, [""])[0]
}

output "nat_instance_az" {
  description = "The instance availability_zone"
  value       = concat(aws_instance.nat.*.availability_zone, [""])[0]
}

output "nat_instance_private_ip" {
  description = "The instance private id address"
  value       = concat(aws_instance.nat.*.private_ip, [""])[0]
}

output "nat_instance_security_group" {
  description = "The associated security groups to the instance"
  value       = concat(aws_instance.nat.*.security_groups, [""])[0]
}

output "nat_instance_subnet" {
  description = "The VPC subnet id where the istance is hosted"
  value       = concat(aws_instance.nat.*.subnet_id, [""])[0]
}

output "nat_instance_state" {
  description = "The state of the instance"
  value       = concat(aws_instance.nat.*.instance_state, [""])[0]
}