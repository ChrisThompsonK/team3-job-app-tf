# Team 3 Job App - Infrastructure Repository

This repository contains Terraform configurations for deploying shared infrastructure for the Team 3 Job Application.

## Structure

```
terraform/
├── providers.tf      # Terraform provider and backend configuration
├── variables.tf      # Input variables
├── main.tf           # Main infrastructure resources
└── outputs.tf        # Output values
```

## Current Resources

### Phase 1: Key Vault
- Azure Resource Group
- Azure Key Vault for storing application secrets
- Access policies for manual secret management

## Prerequisites

- Azure CLI installed and authenticated: `az login`
- Terraform >= 1.0
- Access to Azure subscription with terraform-state-mgmt resource group

## Getting Started

1. Navigate to the terraform directory:
```bash
cd terraform
```

2. Initialize Terraform:
```bash
terraform init
```

3. Review the plan:
```bash
terraform plan
```

4. Apply the configuration:
```bash
terraform apply
```

## Adding Secrets to Key Vault

After applying Terraform, manually add secrets to the Key Vault via Azure Portal:

1. Go to the created Key Vault in Azure Portal
2. Navigate to "Secrets"
3. Add the following secrets:
   - `JWT-ACCESS-SECRET`: JWT access token secret
   - `JWT-REFRESH-SECRET`: JWT refresh token secret
   - `PASSWORD-HASH-ROUNDS`: Bcrypt hash rounds (e.g., "12")

Note: Secret names should use hyphens, not underscores (Azure Key Vault limitation).

## Next Phases

- Phase 2: Managed Identity (for app access to Key Vault and ACR)
- Phase 3: Container App Environment
- Phase 4: Container Apps (Frontend & Backend)

## Outputs

Run `terraform output` to see:
- Resource Group name
- Key Vault ID and URI
- Key Vault name
