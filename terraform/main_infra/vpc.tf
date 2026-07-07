# prod vpc
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 5.0."

    name = "prod_env_vpc"
    cidr = "10.0.0.0/16"

    azs = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]

    public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
    private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]

    enable_nat_gateway = true
    single_nat_gateway = false 
    one_nat_gateway_per_az = true

    enable_dns_hostnames = true
    enable_dns_support   = true

    # Flow logs recomendados em prod
    enable_flow_log                      = true
    create_flow_log_cloudwatch_log_group = true
    create_flow_log_cloudwatch_iam_role  = true

    tags = {
        Environment = "prod"
    }
}

# test environment vpc
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "test_env_vpc"
    cidr = "10.1.0.0/16"

    azs = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
    
    public_subnets = [
        "10.1.0.0/24", # public dev
        "10.1.10.0/24" # public staging
    ]

    private_subnets = [
        "10.1.1.0/24", # private dev
        "10.1.11.0/24" # private staging
    ]

    enable_nat_gateway = true
    single_nat_gateway = true   

    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Environment = "test"
    }
}
