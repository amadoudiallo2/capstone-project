resource "aws_dynamodb_table" "my_dynamo_table" {
  name             = "my-dynamo-metadata-table"
  hash_key         = "employeeid"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "employeeid"
    type = "S"
  }
}

output "dynamo_arn" {
  value = aws_dynamodb_table.my_dynamo_table.arn
}ade:~/environment/capstone-project/firstone (main) $ 
