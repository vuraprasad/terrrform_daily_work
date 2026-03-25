terraform {
    backend "s3" {
        bucket = "vura-terraform-files"
        key="statefiles/terraform-tfstate"
        region = "us-east-1"
      
    }

  
}