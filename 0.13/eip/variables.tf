variable "instance_id" {
  default = ""
}
variable "vpc" {
  type    = bool
  default = true
}
variable "tags" {
  type = map(string)
}
variable "num_eips" {
  default = 1
}
