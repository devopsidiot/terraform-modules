variable "sns_access" {
  type = object(
    {
      topic       = string,
      permissions = set(string)
    }
  )
  description = "Which SNS topic does this application need access to, and with what permissions?"
}

