# Overview
When creating VPC peering accounts within the same AWS account, a single Terraform module can be created that makes the peering request and accepter, as well as route table entries.

When peering across accounts or regions, a similar approach can be taken, but only if the module can make use of multiple Terraform providers - one per account. This may not be desirable (allowing one account-specific repo to reach out and create resources in another account managed by a different repo).


This module will create an peering requestor, only.

See examples dir.
