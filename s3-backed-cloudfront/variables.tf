variable "public_url" { type = string }
variable "bucket_name" { type = string }

variable "service_name" { type = string }

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "error_document" {
  type    = string
  default = "index.html"
}

variable "acl" {
  type    = string
  default = null
}
