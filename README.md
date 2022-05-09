This repo creates a simple MCNA across AWS, Azure and GCP

It has three transits and three spokes attached to each transit.

The following example tfvars can be used for deploying this MCNA.
```
name     = "ab"                                     // Simple name attribute to derive all naming for all objects
cloud    = ["aws", "azure", "gcp"]                  // List of CSPs 
region   = ["us-east-1", "East US", "us-east1"]     // List of regions correspoinding the above CSP list
cidr     = "10.132.0.0/16"                          // A CIDR that will be segment for all transits and spokes.
accounts = ["ab-aws", "ab-azure", "ab-gcp"]         // The list of onboarded CSP account in your controller. The list order should match cloud and region variables.
ha       = true                                     // Set it true to enable HA.
````
Save the above variables and values as **testing.tfvars** file and pass it to plan and apply
```
terraform init
terraform plan -var-file=testing.tfvars
terraform apply -var-file=testing.tfvars
```