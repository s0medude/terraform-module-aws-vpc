resource "aws_internet_gateway" "igw" {
    count   = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0
    vpc_id  = local.vpc_id
    tags = merge(
        {
            "Name" = format("%s", var.name)
        },
        var.tags,
        var.igw_tags,
    )  
}

resource "aws_route_table" "public" {
    count   = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0
    vpc_id  = local.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw[0].id 
    }
    tags = merge(
        {
            "Name" = format("%s-${var.public_subnet_suffix}", var.name)
        },
        var.tags,
        var.public_route_table_tags,
    )
}

resource "aws_route_table_association" "public" {
    count           = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
    subnet_id       = element(aws_subnet.public.*.id, count.index)
    route_table_id  = aws_route_table.public[0].id     
}