output "github_actions_trust_policy" {
  description = "Trust policy role to assume for github actions"
  value       = data.aws_iam_policy_document.github_actions_trust.json
}

output "global_state_bucket_name" {
  value = module.state_bucket.bucket_id
}

output "global_state_lock_table_name" {
  value = module.state_lock_table.table_name
}

output "global_state_kms_key_arn" {
  value = module.state_bucket.kms_key_arn
}