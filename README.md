# VPC + EC2 + Nginx (Terraform Lab)

## Overview
This Terraform lab provisions a complete AWS networking setup (VPC + public subnet + routing) and launches an Ubuntu EC2 instance with Nginx installed automatically using user-data.

It also follows good security practice by restricting SSH access to **only my public IP** using a Terraform variable (`my_ip_cidr`).

---

## What It Creates
- Custom VPC
- Public Subnet
- Internet Gateway
- Route Table + Association
- Security Group (SSH restricted to my IP, HTTP open)
- EC2 Instance (Ubuntu 22.04)
- Nginx installed and running automatically

---

## Tech Stack
- Terraform
- AWS (EC2, VPC, Security Groups)
- Ubuntu 22.04
- Nginx
- Git / GitHub

---

## How to Run

### 1) Init
```bash
terraform init
