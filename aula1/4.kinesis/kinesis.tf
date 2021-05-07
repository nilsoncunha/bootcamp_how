provider "aws" {
  region = "us-east-1"
  profile = "bootcamp"
}

resource "aws_s3_bucket" "bucket_kinesis" {
  bucket = "kineses-bootcamp-how"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_kinesis_firehose_delivery_stream" "kineses_firehose" {
  name = "kinesis-firehose-bootcamp-how"
  destination = "extended_s3"

  extended_s3_configuration {
    bucket_arn = aws_s3_bucket.bucket_kinesis.arn
    role_arn = aws_iam_role.kinesis_role.arn
    buffer_size = 1 # mb
    buffer_interval = 60 # seconds
    compression_format = "GZIP"
    error_output_prefix = "bad_record"
    # The "YYYY/MM/DD/HH" time format prefix is automatically used for delivered S3 files

  }
}

resource "aws_iam_role" "kinesis_role" {
  name = "kinesis-role"
  description = "Role to allow Kinesis to save data to S3"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [aws_iam_policy.kinesis_policy.arn]
}

resource "aws_iam_policy" "kinesis_policy" {
  name = "kinesis-policy"
  description = "Policy to allow kinesis to access S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:AbortMultipartUpload",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:PutObject",
        ],
        Resource = "${aws_s3_bucket.bucket_kinesis.arn}/*"
      }
    ]
  })
}