
// AWS project, It is a AWS Cloud architecture for web hosting:

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.85.0"
    }
  }
}


provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}
