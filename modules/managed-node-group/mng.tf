resource "aws_eks_node_group" "eks_managed_node_group" {
  cluster_name    = var.cluster-name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = aws_iam_role.eks_mng_role.arn
  subnet_ids = [
    var.subnet_private_1a,
    var.subnet_private_1b
  ]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_attachment_cni,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_worker
  ]

  tags = merge(
    var.tags, {
      Name = "${var.project_name}-mng-node-group"
    }
  )
}