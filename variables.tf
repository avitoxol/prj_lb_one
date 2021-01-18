variable "webports" {
  type = list
  default = [80, 443]
}

variable "counting" {
  default = "2"
}

variable "instname" {
  type = list
  default = ["one", "two"]
}
