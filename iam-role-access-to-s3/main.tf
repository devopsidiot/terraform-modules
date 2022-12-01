data "aws_s3_bucket" "s3_bucket_to_access" {
  bucket = var.s3_access["bucket"]
}

data "aws_iam_policy_document" "iam_role_access_to_s3" {
  statement {
    actions = var.s3_access["permissions"]

    resources = [
      "${data.aws_s3_bucket.s3_bucket_to_access.arn}/*"
    ]
  }
}