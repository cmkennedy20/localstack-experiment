resource "aws_s3_bucket" "s3_bucket" {
  bucket = "test-bucket-localstack-for-sdlafkj"
  tags = {
    Name        = "test-bucket"
    Environment = "Dev"
  }
}