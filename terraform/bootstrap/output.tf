output "github_actions_trust_policy" {
  description = "Trust policy role to assume for github actions"
  value       = data.aws_iam_policy_document.github_actions_trust.json
}

output "state_bucket_name" {
  value = aws_s3_bucket.global_infra_bucket.id
}

output "state_lock_table_name" {
  value = aws_dynamodb_table.global_infra_dynamo_table.name
}

output "state_kms_key_arn" {
  value = aws_kms_key.global_infra_kms_key.arn
}