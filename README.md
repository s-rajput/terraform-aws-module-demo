# TerraTest with Golang! 
  
[![N|Solid](https://go.dev/images/go-logo-blue.svg) ](https://nodesource.com/products/nsolid)
  
Terratest is a Go library designed to help you write automated tests for your Infrastructure as Code (IaC), such as Terraform, Packer, Kubernetes, and more. It allows you to deploy real infrastructure, run tests against it, and then tear it down, ensuring your infrastructure code works as expected.

---

## Why use it?

- **Written in Go:** Leverages Go’s testing framework, enabling powerful assertions and test structuring.
- **Automated Testing of Terraform Modules:** Verify that your Terraform modules deploy resources correctly and produce expected outputs.
- **Integration Testing:** Deploy full infrastructure stacks and validate connectivity, configurations, and resource properties.
- **Regression Testing:** Catch infrastructure changes that break existing setups before they reach production.
- **Continuous Integration (CI):** Integrate infrastructure tests into CI pipelines to enforce quality gates.
- **Multi-Cloud Testing:** Write tests that work across AWS, Azure, GCP, and other providers. 
- **Real Infrastructure Testing:** Unlike static linting or syntax checks, Terratest provisions real resources, giving confidence that your code works end-to-end.
- **Reusable Test Helpers:** Comes with modules to handle common retryable errors and simplify Terraform commands.
- **Automated Cleanup:** Automatically destroys test infrastructure to avoid resource leaks and unnecessary costs.
- **Improves Deployment Confidence:** Catch errors early, reducing production incidents and manual troubleshooting.
- **Supports Multiple IaC Tools:** Works with Terraform, Packer, Kubernetes, Docker, and more.
---

 ## Getting Started

### Prerequisites

- [Go](https://golang.org/doc/install) installed (version 1.13+ recommended)
- [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed
- Cloud provider credentials configured (e.g., AWS, Azure)
- Git installed to clone the repository

### Clone the Repository

```
git clone https://github.com/s-rajput/golang-terratest-demo.git
cd golang-terratest-demo 
``` 

### Running the Test

1. Navigate to the test directory:

    ```
    cd test
    ```

2. Run the test with verbose output:

    ```
    go test -v neptune_test.go
    ```

### What Happens During the Test?

- Terraform code from the repository is initialized and applied to provision infrastructure.
- The test runs assertions to verify the deployed infrastructure behaves as expected.
- After the test completes (success or failure), Terraform destroys the infrastructure to avoid leftover resources and costs.

---

## Running Terratest Safely in Production Environments

- **Do NOT run tests directly against production environments.** Use dedicated test or staging environments.
- Review the test code in [`neptune_test.go`](https://github.com/s-rajput/golang-terratest-demo/blob/main/test/neptune_test.go) to understand what resources it creates and modifies.
- Ensure your cloud account has resource quotas and budgets set to prevent runaway provisioning.
- Always rely on the automated cleanup (`defer terraform.Destroy(...)`) but double-check your cloud console for any orphaned resources.
- Use environment variables or configuration files to separate test environment credentials from production.

---
## Additional Resources

- [Terratest Official Documentation](https://terratest.gruntwork.io/docs/getting-started/quick-start/)
- [Terratest GitHub Repository](https://github.com/gruntwork-io/terratest)
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)

---

By integrating Terratest into your Go projects, you ensure your infrastructure is tested, reliable, and production-ready — all while automating deployment and cleanup to reduce manual effort and risk.

---

*Happy Testing!* 🚀
