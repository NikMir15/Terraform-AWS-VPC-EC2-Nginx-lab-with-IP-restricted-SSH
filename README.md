# Terraform AWS VPC + EC2 + Nginx (IP-Restricted SSH)

## Overview
This project provisions a secure AWS infrastructure using **Terraform**.  
It creates a **custom VPC**, deploys an **EC2 instance running Nginx**, and **restricts SSH access to the user’s public IP** following real-world cloud security best practices.

---

## Architecture
- Custom VPC
- Public Subnet
- Internet Gateway + Route Table
- Security Group:
  - SSH (22) → Only from your public IP
  - HTTP (80) → Open to the internet
- EC2 (Ubuntu 22.04, Free Tier eligible)
- Nginx installed via `user_data`

---

## Tech Stack
- Terraform  
- AWS EC2 & VPC  
- Ubuntu 22.04  
- Nginx  

---

## Project Structure
.
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── README.md
├── .gitignore
└── docs/

yaml
Copy code

---

## Security
- SSH restricted using:
  ```hcl
  my_ip_cidr = "80.6.138.183/32"
Private keys and Terraform state files are excluded via .gitignore

How to Run
1. Clone
bash
Copy code
git clone https://github.com/NikMir15/Terraform-AWS-VPC-EC2-Nginx-lab-with-IP-restricted-SSH.git
cd Terraform-AWS-VPC-EC2-Nginx-lab-with-IP-restricted-SSH
2. Initialize
bash
Copy code
terraform init
3. Apply (replace with your public IP)
bash
Copy code
terraform apply -var="my_ip_cidr=YOUR_PUBLIC_IP/32"
Example:

bash
Copy code
terraform apply -var="my_ip_cidr=80.6.138.183/32"
4. Access Nginx
Open in browser:

cpp
Copy code
http://<EC2_PUBLIC_IP>
5. SSH into EC2
bash
Copy code
ssh -i key.pem ubuntu@<EC2_PUBLIC_IP>
Destroy Resources
bash
Copy code
terraform destroy
What This Project Demonstrates
Infrastructure as Code (IaC)

Secure AWS networking

Free Tier–aware EC2 deployment

SSH hardening using CIDR

Automated server provisioning with Terraform

Author
Nikunj Mirajkar
GitHub: https://github.com/NikMir15
LinkedIn: https://www.linkedin.com/in/nikunjmirajkar/