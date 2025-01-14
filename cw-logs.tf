import {
  to = aws_cloudwatch_log_group.log_group
  id = "/aws/lambda/HelloWord"
}

# __generated__ by Terraform from "/aws/lambda/HelloWord"
resource "aws_cloudwatch_log_group" "log_group" {
  log_group_class   = "STANDARD"
  name              = "/aws/lambda/HelloWord"
  retention_in_days = 0
}
