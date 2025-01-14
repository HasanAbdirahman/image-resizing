# Image Resizing

This project provides a scalable solution for dynamically resizing images using AWS Lambda and Terraform. It automates the deployment of necessary infrastructure and integrates logging for efficient monitoring and debugging.

## Features

- **Image Resizing**: Efficiently resizes images on the fly using AWS Lambda.
- **Cloud Logging**: Monitors function execution with AWS CloudWatch Logs.
- **Infrastructure as Code**: Simplifies deployment using Terraform.
- **Customizable Retention**: Configures log retention policies to suit your needs.

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/) (v1.7 or later)
- AWS CLI configured with appropriate permissions
- An AWS account

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/HasanAbdirahman/image-resizing.git
   cd image-resizing
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Deploy the infrastructure:

   ```bash
   terraform apply
   ```

   Confirm the deployment when prompted.

4. Verify the setup in the AWS Management Console.

## File Overview

### `provider.tf`

Defines the required providers (AWS, Random, Archive) and sets the AWS region to `us-east-2`.

### `cw-logs.tf`

Configures an AWS CloudWatch log group for Lambda function logging, with the name `/aws/lambda/HelloWord`.

### `LICENSE`

The project is licensed under the MIT License, allowing free use, modification, and distribution with attribution.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## Author

Hasan Abdirahman

## Acknowledgments

- [Terraform](https://www.terraform.io/) for simplifying infrastructure management.
- [AWS](https://aws.amazon.com/) for providing robust cloud services.
