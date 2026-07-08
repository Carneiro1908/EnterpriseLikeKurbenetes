output "github_actions_trust_policy" {
  description = "Trust policy role to assume for github actions"
  value       = data.aws_iam_policy_document.github_actions_trust.json
}

output "state_bucket_name" {
  value = module.state_bucket.bucket_id
}

output "state_lock_table_name" {
  value = module.state_lock_table.table_name
}

output "state_kms_key_arn" {
  value = aws_kms_key.global_infra_kms_key.arn
}