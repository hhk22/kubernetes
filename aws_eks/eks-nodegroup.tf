resource "aws_eks_node_group" "test-eks-nodegroup" {
  cluster_name    = aws_eks_cluster.test-eks-cluster.name
  node_group_name = "test-eks-nodegroup"
  node_role_arn   = aws_iam_role.test-iam-role-eks-nodegroup.arn
  subnet_ids      = ["subnet-02784bcb3e173a4d6","subnet-09a03515a300c2fe0"]
  instance_types = ["t3a.medium"]
  disk_size = 20

  labels = {
    "role" = "eks-nodegroup"
  }

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup,
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup-cni,
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup-ecr,
  ]

  tags = {
    "Name" = "${aws_eks_cluster.test-eks-cluster.name}-worker-node"
  }
}