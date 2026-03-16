resource "aws_iam_role" "eks_mng_role" {
  name = "${var.project_name}-mng-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

  tags = merge(
    var.tags, {
      Name = "${var.project_name}-mng-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_mng_role_attachment_worker" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_mng_role.name
}

resource "aws_iam_role_policy_attachment" "eks_mng_role_attachment_ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
  role       = aws_iam_role.eks_mng_role.name
}

resource "aws_iam_role_policy_attachment" "eks_mng_role_attachment_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_mng_role.name
}