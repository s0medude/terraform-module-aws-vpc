locals {
  nat_intance_ips = split(
    ",",
    var.reuse_nat_ips ? join(",", var.external_nat_ip_ids) : join(",", aws_eip.nat.*.id),
  )
}

data "aws_ami" "nat-ami" {
    most_recent = true
    filter {
        name    = "name"
        values  = ["amzn-ami-vpc-nat*"]
    }
    owners = ["amazon"]  
}

resource "aws_eip" "nat" {
    count       = var.create_vpc && var.enable_nat_instance ? local.nat_instance_count : 0
    vpc         = var.create_vpc
    instance    = aws_instance.nat[0].id
    depends_on  = [aws_internet_gateway.igw]
    tags = merge(
        {
            "Name" = format(
                "%s-%s",
                var.name,
                element(var.azs, var.single_nat_instance ? 0 : count.index),
            )
        },
        var.tags,
        var.nat_eip_tags,
    )      
}

resource "aws_instance" "nat" {
    count = var.create_vpc && var.enable_nat_instance ? local.nat_instance_count : 0
    ami                         = data.aws_ami.nat-ami.id
    instance_type               = var.nat_instance_type
    source_dest_check           = var.source_dest_check
    subnet_id                   = element(aws_subnet.public.*.id, var.single_nat_instance ? 0 : count.index)
    associate_public_ip_address = var.associate_public_ip_address
    vpc_security_group_ids      = [concat(aws_security_group.nat.*.id, [""])[0]]
    depends_on                  = [aws_internet_gateway.igw]
    tags = merge(
        {
            "Name" = format(
                "%s-%s",
                var.name,
                element(var.azs, var.single_nat_instance ? 0 : count.index),                
            )
        },
        var.tags,
        var.nat_instance_tags,
    )
}

resource "aws_route_table" "private" {
    count   = var.create_vpc && local.max_subnet_length > 0 ? local.nat_instance_count : 0
    vpc_id  = local.vpc_id
    route {
        cidr_block  = "0.0.0.0/0"
        instance_id = aws_instance.nat[0].id
    }
    tags = merge(
        {
            "Name" = var.single_nat_instance ? "${var.name}-${var.private_subnet_suffix}" : format(
                "%s-${var.private_subnet_suffix}-%s",
                var.name,
                element(var.azs, count.index),
            )
        },
        var.tags,
        var.private_route_table_tags,
    )       
}

resource "aws_route_table_association" "private" {
    count           = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
    subnet_id       = element(aws_subnet.private.*.id, count.index)
    route_table_id  = element(
        aws_route_table.private.*.id,
        var.single_nat_instance ? 0 : count.index,
    )  
}




