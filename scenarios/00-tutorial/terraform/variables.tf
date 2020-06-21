#Provider info 
provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/k_shogo/.aws/credentials" # specify aws credential if necessary
  profile = "default" # specify profile in credential if necessary
}