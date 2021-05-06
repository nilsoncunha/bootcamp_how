provider "aws" {
  profile = "bootcamp"
  region = "us-east-1"
}

data "aws_caller_identity" "userid" {}

resource "aws_iam_role" "roleEngineer" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  description = "Funcao para ser assumida por engenheiros de dados"
  managed_policy_arns = [aws_iam_policy.policyEngenieer.arn]
  name = "role-data-engineer"
}

resource "aws_iam_policy" "policyEngenieer" {
  name = "policyEngenieer"
  description = "Politicas de acesso para engenheiro de dados"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:List*",
          "s3:Get*",
          "s3:Delete*",
          "s3:Put*"
        ]
        Resource = "arn:aws:s3:::*"
      },
    ]
  })
}

resource "aws_iam_role" "roleScientist" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  description = "Funcao para ser assumida por cientista de dados"
  managed_policy_arns = [aws_iam_policy.policyScientist.arn]
  name = "role-data-scientist"
}

resource "aws_iam_policy" "policyScientist" {
  name = "policyScientist"
  description = "Politicas de acesso para cientista de dados"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:List*",
          "s3:Get*"
        ]
        Resource = "arn:aws:s3:::*"
      },
    ]
  })
}

resource "aws_iam_group" "groupEngineer" {
  name = "groupEngineer"
}

resource "aws_iam_group_policy" "groupPolicyEngineer" {
  group = aws_iam_group.groupEngineer.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action = [
          "sts:AssumeRole",
        ]
        Resource = aws_iam_role.roleEngineer.arn
      },
    ]
  })
}

resource "aws_iam_group" "groupScientist" {
  name = "groupScientist"
}

resource "aws_iam_group_policy" "groupPolicyScientist" {
  group = aws_iam_group.groupScientist.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action = [
          "sts:AssumeRole",
        ]
        Resource = aws_iam_role.roleScientist.arn
      },
    ]
  })
}