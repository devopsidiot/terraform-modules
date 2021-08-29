# Overview

This module is intended to generate a "bundle" of certificates that have a CN and SANs (subject alternate names) for every domain name in CBS legacy's Route53. Each certificate in the bundle can support 1 CN and 99 SANs. In adddition to each naked domain in route53, a "www." domain should added to the cert bundle.

The bundle itself is a custom module that takes a text list of domain names and creates the appropriate number of of certificates, given the number of domains in the list. The module outputs a list of ARNS of the newly created certificates.

For example, assuming Route53 lists 600 domains, there would be 1200 domain names in the text file, resulting in 12 certificates, each with 100 domain names, within a bundle.

Once a bundle is created, it can be attached to load balancers via an aws_lb_listener_certificate resource.

## Domain Validation (DV) records

 DV records consist of hash of some sort that only AWS knows how to generate. They are unique for each domain name and appear to never change. They are required for a certificate to generate successfully.

If a DV is deleted, an SSL certificate for that domain will no longer renew automatically.

Multiple certificates can be created for the same domain name, independently of one another, all making use of the same DV record to do validation. Therefore, care should be taken when deleting DV records (better yet, never delete them).

## Terraform
 Do not use Terraform to destroy certificates as doing so will delete the corresponding DV records, even if other certificates exist that rely on them (regardless of whether they are Terraform managed or not). **Only delete certificates manually in ACM in web console.**
 
Do not re-apply acm certificates; only ever create new ones. Re-applying will always force recreate certs and DV entries, as there is a bug in the provider that returns both SANS and domain_validation_options in a different order each time. The latter is handled in this configuration but SANS are not. There is a solution in the works, apparently:
https://github.com/terraform-providers/terraform-provider-aws/issues/8531

Therefore, SSL bundles should be single use, only. Create new directories for each certificate bundle being generated, regardless of whether it's a minor change or not.
