# Control Tower VPC

This module provides source for a VPC that originated as an import from Control Tower.

## Usage

Use this module after the VPC has been imported. Example usage:

    inputs = {
        vpc_id   = "vpc-05a31b7f4c722ec7b"
        vpc_cidr = "10.153.0.0/18"

        subnet_cidr_blocks_public = {
            "1a" = "10.153.48.0/24"
            "1b" = "10.153.49.0/24"
            "1c" = "10.153.50.0/24"
        }

        subnet_cidr_blocks_private = {
            "1a" = "10.153.0.0/20"
            "1b" = "10.153.16.0/20"
            "1c" = "10.153.32.0/20"
        }

    }
