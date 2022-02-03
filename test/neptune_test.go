package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformNeptuneExample(t *testing.T) {

	//assemble
	neptuneName := "sr-nepture"
	neptuneCount := 1
	///test expectations
	expectedClusterIdentifier := neptuneName
	expectedEndpointIdentifier := fmt.Sprintf("%s-%d", neptuneName, neptuneCount-1)

	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		// The path to where our Terraform code is located
		TerraformDir: "../neptunedb",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"neptune_name":     neptuneName,
			"neptune_sg_name":  "sr-securitygroup1",
			"neptune_count":    1,
			"public_key_path":  "~/.ssh/id_rsa.pub",
			"private_key_path": "~/.ssh/id_rsa",
			"key_name":         "ssh-tunnel",
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	clusterIdentifier := terraform.Output(t, terraformOptions, "neptune_cluster_identifier")

	//assertions
	// Verify that the clusteridentifier is not null
	assert.NotNil(t, clusterIdentifier)

	// Verify that the clusterIdentifier is as expected
	assert.Equal(t, neptuneName, clusterIdentifier)

}
