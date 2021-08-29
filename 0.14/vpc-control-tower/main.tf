resource "aws_subnet" "public-1a" {
    count = lookup(var.subnet_cidr_blocks_public, "1a") != "" ? 1 : 0

    availability_zone               = "us-east-1a"
    vpc_id                          = var.vpc_id
    cidr_block                      = lookup(var.subnet_cidr_blocks_public, "1a")
    assign_ipv6_address_on_creation = false
    map_public_ip_on_launch         = false

    tags = merge(var.tags, var.public_subnet_tags, {
        "AWS_Solutions" = "CustomControlTowerStackSet"
        "Name"          = "public-1a"
    })

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_subnet" "public-1b" {
    count = lookup(var.subnet_cidr_blocks_public, "1b") != "" ? 1 : 0

    availability_zone              = "us-east-1b"
    vpc_id                          = var.vpc_id
    cidr_block                      = lookup(var.subnet_cidr_blocks_public, "1b")
    assign_ipv6_address_on_creation = false
    map_public_ip_on_launch         = false

    tags = merge(var.tags, var.public_subnet_tags, {
        "AWS_Solutions" = "CustomControlTowerStackSet"
        "Name"          = "public-1b"
    })

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_subnet" "public-1c" {
    count = lookup(var.subnet_cidr_blocks_public, "1c") != "" ? 1 : 0

    availability_zone              = "us-east-1c"
    vpc_id                          = var.vpc_id
    cidr_block                      = lookup(var.subnet_cidr_blocks_public, "1c")
    assign_ipv6_address_on_creation = false
    map_public_ip_on_launch         = false

    tags = merge(var.tags, var.public_subnet_tags, {
        "AWS_Solutions" = "CustomControlTowerStackSet"
        "Name"          = "public-1c"
    })

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_subnet" "private-1a" {
    count = lookup(var.subnet_cidr_blocks_private, "1a") != "" ? 1 : 0

    availability_zone               = "us-east-1a"
    vpc_id                          = var.vpc_id
    cidr_block                      = lookup(var.subnet_cidr_blocks_private, "1a")
    assign_ipv6_address_on_creation = false
    map_public_ip_on_launch         = false

    tags = merge(var.tags, var.private_subnet_tags, {
        "AWS_Solutions" = "CustomControlTowerStackSet"
        "Name"          = "private-1a"
    })

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_subnet" "private-1b" {
    count = lookup(var.subnet_cidr_blocks_private, "1b") != "" ? 1 : 0

    availability_zone               = "us-east-1b"
    vpc_id                          = var.vpc_id
    cidr_block                      = lookup(var.subnet_cidr_blocks_private, "1b")
    assign_ipv6_address_on_creation = false
    map_public_ip_on_launch         = false

    tags = merge(var.tags, var.private_subnet_tags, {
        "AWS_Solutions" = "CustomControlTowerStackSet"
        "Name"          = "private-1b"
    })

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_subnet" "private-1c" {
    count = lookup(var.subnet_cidr_blocks_private, "1c") != "" ? 1 : 0

    availability_zone               = "us-east-1c"
    vpc_id                          = var.vpc_id
    cidr_block                      = lookup(var.subnet_cidr_blocks_private, "1c")
    assign_ipv6_address_on_creation = false
    map_public_ip_on_launch         = false

    tags = merge(var.tags, var.private_subnet_tags, {
        "AWS_Solutions" = "CustomControlTowerStackSet"
        "Name"          = "private-1c"
    })

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_vpc" "vpc" {
    cidr_block                     = var.vpc_cidr
    enable_dns_hostnames           = var.enable_dns_hostnames
    enable_classiclink             = false
    enable_classiclink_dns_support = false
    enable_dns_support             = true
    instance_tenancy               = "default"

    tags = merge(var.tags, {
        "AWS_Solutions" = "CustomControlTowerStackSet"
    })

    lifecycle {
        prevent_destroy = true
    }
}
