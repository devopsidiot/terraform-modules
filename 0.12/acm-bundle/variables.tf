variable "domains" {
  type    = list(string)
  default = []
}
variable "tags" {
  type = map(string)
}
variable "domains_file" {
  type    = string
  default = ""
}
variable "domains_chunks" {
  type = list(any)
}
variable "max_san" {
  type    = string
  default = 100
}
