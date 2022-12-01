variable "sqs_queue_to_create" {
  type = object(
    {
      name = string,
      sns_subscription = list(object(
        {
          topic_name  = string
          filter_policy = string
        }
      ))
    }
  )
  description = "Name of the queue to be created? Does it have any topics to subscribe to?"
}