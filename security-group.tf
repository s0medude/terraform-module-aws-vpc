resource "aws_security_group" "nat" {
    count       = var.create_vpc && var.single_nat_instance ? 1 : 0
    depends_on  = [aws_vpc.vpc]
    name        = "nat-instance-sg"
    vpc_id      = local.vpc_id
    description = "Access to internet via Nat instance"
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.cidr_block_vpc]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(
        {
            "Name" = format("%s", var.name)
        },
        var.tags,
        var.sg_tags
    )
  
}

