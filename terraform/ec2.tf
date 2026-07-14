# Fetch latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# App & Monitoring Node (Public)
resource "aws_instance" "app_node" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.public[0].id
  
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_profile.name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-app-node"
    Role = "app-monitoring"
  }
}

# Database Node (Private)
resource "aws_instance" "db_node" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private[0].id
  
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-db-node"
    Role = "database"
  }
}

# Target Linux Nodes (Private)
resource "aws_instance" "target_nodes" {
  count         = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = var.key_name
  subnet_id     = aws_subnet.private[count.index % length(var.private_subnet_cidrs)]
  
  vpc_security_group_ids = [aws_security_group.target_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_profile.name

  tags = {
    Name = "${var.project_name}-target-node-${count.index + 1}"
    Role = "target"
  }
}
