output "PagerDuty_Service_Name" {
  value = pagerduty_service.pd_service.name
}

output "AWS_SNS_Topic" {
  value = aws_sns_topic.pd_topic.name
}

output "AWS_SNS_Topic_Arn" {
  value = aws_sns_topic.pd_topic.arn
}
