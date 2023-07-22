variable "vpc-cidr-block" {
  default = "10.0.0.0/16"
}

variable "public-sn-1-cidr_block" {
  default = "10.0.1.0/24"
}

variable "private-sn-2-cidr_block" {
  default = "10.0.2.0/24"
}

variable "private-sn-3-cidr_block" {
  default = "10.0.3.0/24"
}

variable "private-sn-4-cidr_block" {
  default = "10.0.4.0/24"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_value" {
  default = "ami-06b09bfacae1453cb"
}

variable "key-name" {
  default = "DemoKeyPair"
}

variable "availability_zone_1" {
  default = "us-east-1a"
}

variable "availability_zone_2" {
  default = "us-east-1b"
}

variable "availability_zone_3" {
  default = "us-east-1c"
}

variable "bucketName" {
  default = "my-static-s3-bucket-003"
}
