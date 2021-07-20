terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}
terraform {
  backend "s3" {
    bucket = "karthik-infra"
    key    = "infra/spring-boot/terraform.tfstate"
  }
}
//resource "aws_eks_cluster" "this" {
//  name     = "spring-boot"
//  role_arn = aws_iam_role.this.arn
//
//  vpc_config {
//    subnet_ids = var.subnets
//  }
//  depends_on = [
//    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
//    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
//  ]
//}
//
//##### IAM roles and policies
//resource "aws_iam_role" "this" {
//  name = "eks-cluster-role"
//
//  assume_role_policy = <<POLICY
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Principal": {
//        "Service": "eks.amazonaws.com"
//      },
//      "Action": "sts:AssumeRole"
//    },
//    {
//      "Effect": "Allow",
//      "Principal": {
//        "Service": "ec2.amazonaws.com"
//      },
//      "Action": "sts:AssumeRole"
//    }
//  ]
//}
//POLICY
//}
//
//resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
//  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
//  role       = aws_iam_role.this.name
//}
//resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
//  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
//  role       = aws_iam_role.this.name
//}
//
//resource "aws_security_group" "worker_group_mgmt_one" {
//  name_prefix = "worker_group_mgmt_one"
//  vpc_id      = var.vpc_id
//
//  ingress {
//    from_port = 22
//    to_port   = 22
//    protocol  = "tcp"
//
//    cidr_blocks = [
//      "10.0.3.0/24",
//    ]
//  }
//}
//data "aws_ssm_parameter" "cluster" {
//  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.this.version}/amazon-linux-2/recommended/image_id"
//}
//
//data "aws_launch_template" "cluster" {
//  name = aws_launch_template.cluster.name
//
//  depends_on = [aws_launch_template.cluster]
//}
//
//resource "aws_launch_template" "cluster" {
//  image_id               = data.aws_ssm_parameter.cluster.value
//  instance_type          = "t2.small"
//  name                   = "spring-boot-lt"
//  update_default_version = true
//
//  key_name = "karthik-ec2"
//
//  block_device_mappings {
//    device_name = "/dev/xvda"
//
//    ebs {
//      volume_size = 8
//    }
//  }
//
//  tag_specifications {
//    resource_type = "instance"
//
//    tags = {
//      Name  = "spring-boot-app"
//    }
//  }
//
//  user_data = base64encode(templatefile("userdata.tpl", { CLUSTER_NAME = aws_eks_cluster.this.name, B64_CLUSTER_CA = aws_eks_cluster.this.certificate_authority[0].data, API_SERVER_URL = aws_eks_cluster.this.endpoint }))
//}
//module "eks-node-group" {
//  source = "./modules/node-group"
//
//  cluster_name = aws_eks_cluster.this.name
//  node_group_name = "spring-boot-1"
//
//  subnet_ids = var.subnets
//
//  desired_size = 1
//  min_size     = 1
//  max_size     = 2
//
//  launch_template = {
//    id = data.aws_launch_template.cluster.id
//    version = data.aws_launch_template.cluster.latest_version
//  }
//
//  labels = {
//    lifecycle = "OnDemand"
//    Name = "spring-boot"
//  }
//
//  tags = {
//    Environment                 = "test"
//  }
//
//  depends_on = [data.aws_launch_template.cluster]
//}
//resource "aws_ecr_repository" "spring-boot" {
//  name                 = "spring-boot"
//  image_tag_mutability = "IMMUTABLE"
//
//  image_scanning_configuration {
//    scan_on_push = true
//  }
//}
//resource "aws_ecr_repository" "charts" {
//  name                 = "charts"
//  image_tag_mutability = "IMMUTABLE"
//
//  image_scanning_configuration {
//    scan_on_push = true
//  }
//}