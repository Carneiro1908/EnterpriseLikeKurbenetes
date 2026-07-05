import json
import sys
from policy_sentry.shared.database import connect_db
from policy_sentry.writing.sid_group import SidGroup

def generate_least_privilege_policy(arns_list, policy_name="AutomatedTerraformPolicy"):
    """
    Generates a least-privilege IAM policy JSON based on a list of AWS ARNs
    using the policy_sentry library.
    """
    try:
        # 1. Connect to the bundled SQLite database containing AWS actions/permissions
        db_session = connect_db('bundled')
    except Exception as e:
        print(f"Error connecting to policy_sentry database: {e}", file=sys.stderr)
        print("Please run 'policy_sentry initialize' first.", file=sys.stderr)
        sys.exit(1)

    # 2. Define the CRUD configuration dictionary dynamically.
    # Instead of a YAML file, we map our dynamic ARNs directly to CRUD categories.
    policy_config = {
        "mode": "CRUD",
        "name": policy_name,
        "read": arns_list,
        "write": arns_list,
        "list": arns_list,
        "tagging": arns_list,
        "permissions-management": []  # Kept empty by default for security/least-privilege
    }

    # 3. Initialize the SidGroup to process the requested actions against the database
    sid_group = SidGroup()
    sid_group.process_requested_actions(db_session, policy_config)

    # 4. Render the final IAM Policy as a Python dictionary
    rendered_policy = sid_group.get_rendered_policy(db_session)
    
    return rendered_policy

if __name__ == "__main__":
    # Example list of ARNs. In a production pipeline, you would populate this list
    # by parsing your 'terraform plan -json' or 'terraform.tfstate' file.
    extracted_arns = [
        "arn:aws:s3:::my-production-data-bucket",
        "arn:aws:s3:::my-production-data-bucket/*",
    ]

    print("Generating least-privilege IAM policy...")
    
    # Generate the policy
    iam_policy = generate_least_privilege_policy(
        arns_list=extracted_arns, 
        policy_name="TerraformDeployPolicy"
    )

    # Output the result as a formatted JSON string
    json_output = json.dumps(iam_policy, indent=4)
    print("\nGenerated IAM Policy JSON:")
    print(json_output)

    # Optional: Save the output directly to a file
    output_filename = "iam_policy_output.json"
    with open(output_filename, "w") as f:
        f.write(json_output)
    print(f"\nSuccess! Policy saved to {output_filename}")