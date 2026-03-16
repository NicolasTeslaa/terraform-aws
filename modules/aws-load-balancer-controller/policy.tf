resource "aws_iam_policy" "policy" {
  name = "${var.project_name}-aws-load-balancer"

  policy = file("${path.module}/iam_policy.json")

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-load-balancer"
    }
  )
}