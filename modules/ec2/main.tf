# 1. Generate SSH Private Key
resource "tls_private_key" "nithin_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Create AWS Key Pair
resource "aws_key_pair" "generated_key" {
  key_name   = "nithin-terraform-key"
  public_key = tls_private_key.nithin_key.public_key_openssh
}

# 3. Save Private Key to your computer as .pem file
resource "local_file" "private_key_pem" {
  content  = tls_private_key.nithin_key.private_key_pem
  filename = "${path.root}/nithin-key.pem"
  file_permission = "0400"
}
# Security Group to allow SSH and Strapi port
resource "aws_security_group" "strapi_sg" {
  name        = "strapi_sg_nithin"
  description = "Allow SSH and Strapi traffic"

  # SSH (Port 22) allow
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Strapi (Port 1337) allow
  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules (Allow all)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. Create EC2 Instance
resource "aws_instance" "strapi_instance" {
  ami           = "ami-08eb150f611ca277f" # Ubuntu 24.04 in Stockholm
  instance_type = "t3.micro"               #
  key_name      = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  tags = {
    Name = "Strapi-Server-Nithin"
  }
}

# 5. Output the Public IP
