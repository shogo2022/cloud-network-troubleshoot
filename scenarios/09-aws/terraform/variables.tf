variable "region" {
  default = "us-east-1"
}

#Provider info 
provider "aws" {
  region  = var.region
  profile = "default" # specify profile in credential if necessary
}

