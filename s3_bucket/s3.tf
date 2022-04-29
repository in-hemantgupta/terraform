provider "aws" {
  region="ap-south-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "hg-test-tf-state-bucket-22"
  acl    = "private"
  versioning {
    enabled = true
  }
}

resource "aws_iam_policy" "tf-state-bucket-policy" {
  name = "tf-state-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::mybucket"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::hg-test-tf-state-bucket-22/tf-state-file"
    }
  ]
}
EOF
}

terraform {
  backend "s3" {
    bucket = "hg-test-tf-state-bucket-22"
    key    = "tf-state-file"
    region = "ap-south-1"
  }
}