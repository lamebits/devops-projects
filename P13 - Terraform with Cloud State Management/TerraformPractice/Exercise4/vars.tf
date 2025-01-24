variable "region" {
  default = "us-east-2"
}
variable "zone" {
  default = "us-east-2a"
}
variable "webuser" {
  default = "ubuntu"
}
variable "amiID" {
  type = map(any)
  default = {
    us-east-1 = "ami-04b4f1a9cf54c11d0"
    us-east-2 = "ami-0cb91c7de36eed2cb"
  }
}