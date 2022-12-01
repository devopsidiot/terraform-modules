variable "s3_access" {
  type = object(
    {
      bucket       = string,
      permissions = set(string)
    }
  )
  description = "What S3 bucket is this applicaion creating, and with what permissions?"
}