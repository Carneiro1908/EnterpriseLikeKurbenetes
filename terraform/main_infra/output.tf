# prod env vpc
output "prod_env_vpc_id" {
  value = module.prod_env_vpc.prod_env_vpc_id
}

output "private_subnet_ids" {
  value = module.prod_env_vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.prod_env_vpc.public_subnets
}

# test env vpc
output "test_env_vpc_id" {
  value = module.test_env_vpc.test_env_vpc_id
}

output "private_subnet_ids" {
  value = module.test_env_vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.test_env_vpc.public_subnets
}