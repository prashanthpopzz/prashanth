To create a custom VPC in AWS using Terraform and retrieve the outputs such as subnet IDs, VPC ID, and security group IDs, you can follow these steps. Terraform allows you to define infrastructure as code, which makes it easier to manage and reproduce your AWS resources.

**Step-by-Step Guide:**
**1. Initialize Terraform**
First, make sure you have Terraform installed and initialized in your project directory.

bash
Copy code
terraform init

**2. Configure AWS Provider:**
Create a main.tf file and configure the AWS provider with your AWS credentials and region.

hcl
Copy codem  
provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}
**3. Define VPC Resources:**
Create a VPC along with subnets and security groups. Below is an example of creating a VPC with a single public subnet and a security group allowing SSH access:

hcl
Copy code
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"  # Specify your preferred availability zone
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySecurityGroup"
  }
}
4. Define Outputs
Define outputs in your main.tf to retrieve information about the resources created. Outputs allow you to view important information after Terraform has applied the configuration.

hcl
Copy code
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "security_group_id" {
  value = aws_security_group.my_security_group.id
}
5. Apply the Configuration
Run terraform apply to create the infrastructure defined in your configuration file.

bash
Copy code
terraform apply
6. Retrieve Outputs
After the apply completes successfully, Terraform will output the values defined in the output section. You can retrieve these values using terraform output command.

bash
Copy code
terraform output vpc_id
terraform output subnet_id
terraform output security_group_id
These commands will display the respective IDs of the VPC, subnet, and security group that Terraform has created.

Notes
Make sure to replace region, cidr_block, availability_zone, and other values with your specific requirements.
Adjust security group rules (ingress and egress blocks) as per your security policies.
Always review and modify AWS resource configurations based on your specific security and operational requirements.
By following these steps, you can create a custom VPC in AWS using Terraform and easily retrieve the IDs of the created resources. Adjustments can be made to suit more complex networking architectures or additional security requirements as needed.
