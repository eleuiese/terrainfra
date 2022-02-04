data "aws_vpc" "vpc_main" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnet1" {
  id = var.public_subnet1_id
}

data "aws_subnet" "public_subnet2" {
  id = var.public_subnet2_id
}

resource "aws_ecs_cluster" "django-cluster" {
  name = "django-cluster"
}

resource "aws_ecs_task_definition" "django_task_definition" {
  family                   = "django-task-definition"
  task_role_arn            = var.ecs_task_role
  execution_role_arn       = var.ecs_task_execution_role
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "1024"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "eleuiese/djangoapp:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000
        }
      ]
    }
  ])
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_ecs_service" "calc" {
  name                               = "DjangoService"
  task_definition                    = aws_ecs_task_definition.django_task_definition.arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  cluster                            = aws_ecs_cluster.django-cluster.id
  platform_version                   = "LATEST"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  scheduling_strategy                = "REPLICA"
  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_fargate_sg.id]
    subnets          = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }
}

#security_groups

resource "aws_security_group" "ecs_fargate_sg" {
  name        = "ecs_fargate_Sg"
  vpc_id      = data.aws_vpc.vpc_main.id
  description = "Permitir http"

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs_fargate_sg"
  }
}