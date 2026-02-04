# Strapi v5 Deployment using Modular Terraform on AWS

This repository contains a professional DevOps task focused on automating infrastructure provisioning and deploying a Strapi v5 application on an AWS EC2 instance using Terraform modules.

## 🚀 Project Overview
The goal of this project was to create a reusable and modular infrastructure as code (IaC) setup to deploy a high-performance CMS (Strapi) while overcoming common resource constraints on cloud instances.

## 🏗️ Architecture & Folder Structure
The project follows a modular approach to ensure scalability and clean code management.

```text
strapi-terraform-task/
├── main.tf              # Root configuration calling the EC2 module
├── modules/
│   └── ec2/
│       ├── main.tf      # Logic for EC2 instance and Security Groups
│       ├── variables.tf # Input variables (AMI, Instance Type, etc.)
│       └── outputs.tf   # Outputs (Public IP, Instance ID)
└── README.md            # Project documentation
🛠️ Challenges Faced & Solutions
1. Security Group Configuration
Issue: Initially, SSH connection timed out and Port 1337 was unreachable.

Solution: Updated the Security Group rules to allow inbound traffic on Port 22 (SSH) and Port 1337 (Strapi). Fixed syntax error from cidrs_blocks to cidr_blocks.

2. Node.js Version Compatibility
Issue: Strapi v5 requires Node.js v20.0.0 or higher, but the default was lower.

Solution: Upgraded the EC2 instance environment to Node.js v20.20.0 using NVM.

3. Memory Constraints (t3.micro)
Issue: The npm install process hung due to low RAM (1GB) on the t3.micro instance.

Solution: Successfully implemented 2GB of Swap Memory to provide virtual RAM, allowing the installation to complete smoothly.

✅ Verification
The deployment was verified by successfully accessing the Strapi Admin Panel at: http://16.171.21.210:1337/admin

Developed by: Settibathula Nithin
