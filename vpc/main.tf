
module "vpc" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git?ref=v3.0.0"

  name = var.vpc_name

  cidr = var.vpc_cidr # 10.0.0.0/8 is reserved for EC2-Classic

  azs = var.vpc_azs

  # cidr plan
  #   -was designed with /16 cidr's in mind but will work with anything larger than a /24 without changes
  #   -increasing a cidr prefix by 1 bit cuts it in half.
  #   i.e.
  /*
    ❯ ipcalc 10.2.0.0/16
      Address:   10.2.0.0             00001010.00000010. 00000000.00000000
      Netmask:   255.255.0.0 = 16     11111111.11111111. 00000000.00000000
      Wildcard:  0.0.255.255          00000000.00000000. 11111111.11111111
      =>
      Network:   10.2.0.0/16          00001010.00000010. 00000000.00000000
      HostMin:   10.2.0.1             00001010.00000010. 00000000.00000001
      HostMax:   10.2.255.254         00001010.00000010. 11111111.11111110
      Broadcast: 10.2.255.255         00001010.00000010. 11111111.11111111
      Hosts/Net: 65534                 Class A, Private Internet

      ❯ ipcalc 10.2.0.0/17
      Address:   10.2.0.0             00001010.00000010.0 0000000.00000000
      Netmask:   255.255.128.0 = 17   11111111.11111111.1 0000000.00000000
      Wildcard:  0.0.127.255          00000000.00000000.0 1111111.11111111
      =>
      Network:   10.2.0.0/17          00001010.00000010.0 0000000.00000000
      HostMin:   10.2.0.1             00001010.00000010.0 0000000.00000001
      HostMax:   10.2.127.254         00001010.00000010.0 1111111.11111110
      Broadcast: 10.2.127.255         00001010.00000010.0 1111111.11111111
      Hosts/Net: 32766                 Class A, Private Internet
  */
  #   
  # 
  #  pseudocode: 
  #  divide incoming cidr in half ( +1 bit ) 
  #  first half is used for private subnets ( A )
  #  second half is used for everything else ( B )
  #  private_subnets contains the first 3 oddly numbered subnets of A +5 bits by default (value of newbits variable)
  #  public_subnets contains the first 3 oddly numbered subnets of B +7 bits by default (value of newbits variable)
  #  database_subnets contains the 4 through 6th oddly numbered subnets of B +7 bits by default (value of newbits variable)
  #  intra_subnets contains the 7 through 9th  oddly numbered subnets of B +7 bits by default (value of newbits variable)
  #
  #  https://www.terraform.io/docs/language/functions/cidrsubnet.html
  #  cidrsubnet(prefix, newbits, netnum)
  #
  #  prefix must be given in CIDR notation, as defined in RFC 4632 section 3.1.
  #
  #  newbits is the number of additional bits with which to extend the prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20.
  #
  #  netnum is a whole number that can be represented as a binary integer with no more than newbits binary digits, which will be used to populate the additional bits added to the prefix.
  #  netnum selects which of the subnets returned by cidrsubnet is selected.
  #  increasing a cidr by 1 bit cuts it in half.
  private_subnets = [
    for netnum in [1, 3, 5] :   #here we are selecting 1st, 3rd and 5th available subnet available in the first half of the cidr
    cidrsubnet(                 #use odd subnets to leave empty space
      local.first_half_of_cidr, #select the first half of the cidr. 
      var.private_newbits,      #this + the cidr prefix are added to create the size of each subnet
      netnum                    # netnum selects which subnet is returned
    )
  ] #collect subnets into list
  public_subnets = [
    for netnum in [1, 3, 5] :
    cidrsubnet(
      local.second_half_of_cidr,
      var.infra_newbits,
      netnum
    )
  ]
  database_subnets = [
    for netnum in [7, 9, 11] :
    cidrsubnet(
      local.second_half_of_cidr,
      var.infra_newbits,
      netnum
    )
  ]
  intra_subnets = [
    for netnum in [13, 15, 17] :
    cidrsubnet(
      local.second_half_of_cidr,
      var.infra_newbits,
      netnum
    )
  ]

  create_database_subnet_group = true

  manage_default_route_table = true
  default_route_table_tags   = { DefaultRouteTable = true }

  enable_dns_hostnames = true
  enable_dns_support   = true


  enable_nat_gateway = true
  single_nat_gateway = true

  enable_vpn_gateway = true

  enable_dhcp_options              = false
  dhcp_options_domain_name         = "service.consul"
  dhcp_options_domain_name_servers = ["127.0.0.1", cidrhost(var.vpc_cidr, 2)] #  the VPC-provided DNS IP address will always be your VPC CIDR block “plus two.”


  # Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group = true
  default_security_group_ingress = [
    {
      description = "ssh to VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr #this will will allow ingress via ssh from THIS vpc.
    },
    {
      description = "https to VPC"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0" }
  ]
  default_security_group_egress = [
    {
      description = "Allow all Egress"
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

}

resource "aws_wafv2_ip_set" "Global-WhiteList" {
  name = "Global-WhiteList"

  scope              = "REGIONAL"
  ip_address_version = "IPV4"

  addresses = [
    "199.195.203.42/32", #Cisco Meraki - Fireline ISP - Primary LAN/VPN
    "44.197.4.128/32",   #Cisco Meraki - AWS based VPN
    "3.225.37.175/32",   #Reflect.run - QA Automated Web Testing Tool - Public IP
    "104.224.12.0/22",   #Prerender - Tool for rendering web pages for crawlers
    "168.119.133.64/27", #Prerender
    "188.34.148.112/28", #Prerender
    "188.34.148.128/25", #Prerender
    "188.34.149.0/27",   #Prerender
    "38.122.74.18/32",   #WhiteHat - Security Scanning for Applications
    "50.207.94.58/32",   #WhiteHat
    "50.207.94.59/32",   #WhiteHat
    "52.204.38.40/32",   #WhiteHat
    "63.128.163.0/27",   #WhiteHat
    "64.244.165.6/32",   #WhiteHat
    "162.223.124.0/27",  #WhiteHat
    "162.244.4.2/32",    #WhiteHat
    "162.244.4.3/32",    #WhiteHat
    "162.244.4.5/32",    #WhiteHat
    "162.244.4.6/32",    #WhiteHat
    "162.244.5.2/32",    #WhiteHat
    "162.244.5.3/32",    #WhiteHat
    "162.244.5.5/32",    #WhiteHat
    "162.244.5.6/32",    #WhiteHat
    "148.253.176.50/32", #WhiteHat
    "194.46.129.108/32", #WhiteHat
    "54.93.186.146/32",  #WhiteHat
    "54.229.46.147/32",  #WhiteHat
    "148.253.176.50/32", #WhiteHat
    "194.46.129.108/32", #WhiteHat
  ]
}
    
locals{
  waf_names = [ "Global-WhiteList", "PublicBotControl"]
  waf_params = {
    "Global-WhiteList" = {
      default_action = "block"
      ip_sets_rule = [
        {
          name       = "Global-WhiteList"
          action     = "allow"
          priority   = 1
          ip_set_arn = aws_wafv2_ip_set.Global-WhiteList.arn
        }
      ]
      managed_rules = []
    },
    "PublicBotControl" = {
      default_action = "allow"
      ip_sets_rule = []
      managed_rules = [
        {
          "excluded_rules": [],
          "name": "AWSManagedRulesBotControlRuleSet",
          "override_action": "none",
          "priority": 10
        },
        {
          "excluded_rules": [],
          "name": "AWSManagedRulesCommonRuleSet",
          "override_action": "none",
          "priority": 20
        },
        {
          "excluded_rules": [],
          "name": "AWSManagedRulesAmazonIpReputationList",
          "override_action": "none",
          "priority": 30
        },
        {
          "excluded_rules": [],
          "name": "AWSManagedRulesKnownBadInputsRuleSet",
          "override_action": "none",
          "priority": 40
        },
        {
          "excluded_rules": [],
          "name": "AWSManagedRulesSQLiRuleSet",
          "override_action": "none",
          "priority": 50
        },
        {
          "excluded_rules": [],
          "name": "AWSManagedRulesLinuxRuleSet",
          "override_action": "none",
          "priority": 60
        },
        {
          "excluded_rules": [],
          "name": "AWSManagedRulesUnixRuleSet",
          "override_action": "none",
          "priority": 70
        }
      ]
    }
  }
}
    
module "VPC_WAFs" {
  count = length(local.waf_names)
  source  = "trussworks/wafv2/aws"
  version = "2.4.0"

  name  = local.waf_names[count.index]
  scope = "REGIONAL"

  default_action = local.waf_params[local.waf_names[count.index]].default_action
  ip_sets_rule = local.waf_params[local.waf_names[count.index]].ip_sets_rule
  managed_rules = local.waf_params[local.waf_names[count.index]].managed_rules
}
 
