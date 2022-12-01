variable "sqs_access" {
  type = object(
    {
      queue       = string,
      permissions = set(string)
    }
  )
  description = "Which SQS queue does this application need access to, and with what permissions?"
}