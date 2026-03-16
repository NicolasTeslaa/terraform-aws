resource "aws_iam_role" "eks_cluester_role"{
    name = "${var.project_name}-cluster-role"

    assume_role_policy = jsondecode(
        {
            Version = "2012-10-17"
            Statement = [
                {
                    Action = "sts:AssumeRole"
                    Effect = "Allow"
                    Sid = ""
                    Principal = {
                        Service = "eks.amazonaws.com"
                    }
                }
            ]
        }
    )

   tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cluster-role"
    }
  )
}
