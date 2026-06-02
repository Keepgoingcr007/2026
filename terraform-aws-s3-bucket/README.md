# AWS S3 Bucket Terraform Module

## Requirements
- Terraform >= 1.0
- AWS Provider >= 4.0

## Usage
```hcl
module "s3_bucket" {
  source = "./terraform-aws-s3-bucket"
  
  bucket_name = "my-app-bucket"
  acl         = "private"
}