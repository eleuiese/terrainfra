terraform {
  backend "s3" { 
    bucket = "django-state"
    key    = "infra.tfstate"
    region = "us-east-2"
    encrypt = true
  }
}

