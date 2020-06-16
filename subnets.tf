resource "aws_subnet" "public" {
    count = var.create_vpc && length(var.public_subnets) > 0 && (false == var.one_nat_instance_per_az || length(var.public_subnets) >= length(var.azs)) ? length(var.public_subnets) : 0
    vpc_id                  = local.vpc_id
    cidr_block              = element(concat(var.public_subnets, [""]), count.index)
    availability_zone       = element(var.azs, count.index)
    map_public_ip_on_launch = var.map_public_ip_on_launch
    tags = merge(
        {
            "Name" = format(
                "%s-${var.public_subnet_suffix}-%s",
                var.name,
                element(var.azs, count.index),
            )
        },
        var.tags,
        var.public_subnet_tags,
    )
}

resource "aws_subnet" "private" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id                          = local.vpc_id
  cidr_block                      = var.private_subnets[count.index]
  availability_zone               = element(var.azs, count.index)  
  tags = merge(
        {
            "Name" = format(
                "%s-${var.private_subnet_suffix}-%s",
                var.name,
                element(var.azs, count.index),
            )
        },
        var.tags,
        var.private_subnet_tags,
  )
}

