resource "aws_iam_policy" "ec2_and_elb_policy" {
  name        = "EC2AndELBPolicy"
  description = "Policy to allow EC2 DescribeAvailabilityZones and ELB actions for ALB controller"

  policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Effect = "Allow"
      Action = [
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSubnets",
        "ec2:CreateSecurityGroup",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:CreateTags",
        "ec2:DescribeVpcs",
        "ec2:DeleteSecurityGroup",
        "elasticloadbalancing:AddTags",
        "elasticloadbalancing:CreateListener",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:CreateRule",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DeleteListener",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:DeleteRule",
        "elasticloadbalancing:DeleteTargetGroup",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:ModifyTargetGroup",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:RemoveTags",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:SetSecurityGroups",
        "shield:GetSubscriptionState",
        "tag:GetResources",
        "tag:TagResources",
        "tag:UntagResources"
      ]
      Resource = "*"
    }
  ]
})
}

resource "aws_iam_role_policy_attachment" "attach_ec2_and_elb_policy" {
policy_arn = aws_iam_policy.ec2_and_elb_policy.arn
role       = "main-eks-node-group-20241030064305192700000001"
}
