# create s3  then trigger lambda fn
# then resize the image then store that image in the s3

resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "image_bucket" {
  bucket = "image-bucket-${random_id.bucket_suffix.hex}"
  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.image_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.image_bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/"
    filter_suffix       = ".log"
  }
  depends_on = [aws_lambda_permission.allow_bucket]
}
