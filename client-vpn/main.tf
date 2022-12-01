resource "tls_private_key" "ca" {
  algorithm = "RSA"
}
resource "tls_private_key" "root" {
  algorithm = "RSA"
}
resource "tls_private_key" "server" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name  = "${var.name}.vpn.ca"
    organization = "devopsidiot"
  }

  validity_period_hours = 87600 #10 years
  is_ca_certificate     = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

resource "tls_cert_request" "root" {
  private_key_pem = tls_private_key.root.private_key_pem

  subject {
    common_name  = "${var.name}.vpn.client"
    organization = "devopsidiot"
  }
}

resource "tls_locally_signed_cert" "root" {
  cert_request_pem   = tls_cert_request.root.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name  = "${var.name}.vpn.server"
    organization = "devopsidiot"
  }
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "server" {
  private_key       = tls_private_key.server.private_key_pem
  certificate_body  = tls_locally_signed_cert.server.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}

resource "aws_acm_certificate" "root" {
  private_key       = tls_private_key.root.private_key_pem
  certificate_body  = tls_locally_signed_cert.root.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}

resource "aws_acm_certificate" "ca" {
  private_key      = tls_private_key.ca.private_key_pem
  certificate_body = tls_self_signed_cert.ca.cert_pem
}

resource "aws_cloudwatch_log_group" "vpn" {
  name              = "/aws/vpn/${var.name}/logs"
  retention_in_days = var.logs_retention
  tags = {
    Name    = "${var.name}-Client-VPN-Log-Group",
    EnvName = var.name
  }
}

resource "aws_cloudwatch_log_stream" "vpn" {
  name           = "vpn-usage"
  log_group_name = aws_cloudwatch_log_group.vpn.name
}

resource "aws_ec2_client_vpn_endpoint" "client-vpn-endpoint" {
  description            = "${var.name}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  dns_servers            = [cidrhost(var.vpc_cidr, 2)] #aws provided dns server is at CIDR + 2 
  client_cidr_block      = var.client_cidr
  split_tunnel           = true
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.root.arn
  }
  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }
  tags = {
    Name = var.name
  }
}

resource "aws_ec2_client_vpn_network_association" "client-vpn-endpoint" {
  count                  = length(var.private_subnets)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-endpoint.id
  subnet_id              = element(var.private_subnets, count.index)
}

resource "aws_ec2_client_vpn_authorization_rule" "client_vpn_ingress_auth" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-endpoint.id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
  depends_on             = [aws_ec2_client_vpn_route.client-vpn-route]
}

resource "aws_ec2_client_vpn_route" "client-vpn-route" {
  count                  = length(var.private_subnets)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-endpoint.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = element(var.private_subnets, count.index)
  depends_on             = [aws_ec2_client_vpn_network_association.client-vpn-endpoint]
}

data "aws_vpc" "peered_vpc" {
  count = var.peered_vpc != null ? 1 : 0
  id = var.peered_vpc
}

data "aws_route_tables" "acceptor" {
  count  = var.peered_vpc != null ? 1 : 0
  vpc_id = join("", data.aws_vpc.peered_vpc.*.id)
}

data "aws_vpc_peering_connection" "peer_vpc" {
  count = var.peered_vpc != null ? 1 : 0
  peer_vpc_id          = var.peered_vpc
}

resource "aws_ec2_client_vpn_route" "peered-vpc-route" {
  count                  = var.peered_vpc != null ? length(var.private_subnets) : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-endpoint.id
  destination_cidr_block = data.aws_vpc.peered_vpc[0].cidr_block
  target_vpc_subnet_id   = element(var.private_subnets, count.index)
  depends_on             = [aws_ec2_client_vpn_network_association.client-vpn-endpoint]
}

resource "aws_route" "acceptor" {
  count                     = var.peered_vpc != null ? length(distinct(sort(data.aws_route_tables.acceptor.0.ids))) : 0
  route_table_id            = element(distinct(sort(data.aws_route_tables.acceptor.0.ids)), ceil(count.index))
  destination_cidr_block    = var.client_cidr
  vpc_peering_connection_id = join("", data.aws_vpc_peering_connection.peer_vpc.*.id)
  depends_on                = [aws_ec2_client_vpn_network_association.client-vpn-endpoint]
}

resource "local_sensitive_file" "ovpn_config" {
  content = templatefile("${path.module}/client-vpn.ovpn.tpl",
    {
      endpoint = substr(aws_ec2_client_vpn_endpoint.client-vpn-endpoint.dns_name, 2, -1)
      ca       = tls_self_signed_cert.ca.cert_pem
      cert     = tls_locally_signed_cert.root.cert_pem
      key      = tls_private_key.root.private_key_pem
  })
  file_permission      = "0600"
  directory_permission = "0700"
  filename             = join("/", [var.home_dir, var.output_file_path, "${var.name}.ovpn"])
}

resource "aws_s3_bucket" "config_bucket" {
  bucket = "devopsidiot-configs-${var.environment}"
  acl    = "private"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.config_bucket.id
  key    = "ovpn/${var.environment}-eks-devopsidiot.ovpn"
  content = templatefile("${path.module}/client-vpn.ovpn.tpl",
    {
      endpoint = substr(aws_ec2_client_vpn_endpoint.client-vpn-endpoint.dns_name, 2, -1)
      ca       = tls_self_signed_cert.ca.cert_pem
      cert     = tls_locally_signed_cert.root.cert_pem
      key      = tls_private_key.root.private_key_pem
  })
  content_type = "plain/text"
}
