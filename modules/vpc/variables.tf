# 同一階層にあるresource内で使用するための変数を定義する

variable "cidr_block" {
  description = "vpc cidr block"
  type = string
  default = "192.168.0.0/16"
  nullable = false
}

variable "az" {
  description = "available AZs"
  type = list(string)
  default = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"] 
  nullable = false
}