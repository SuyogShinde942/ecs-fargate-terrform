resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster_name}-${var.env}"
}

resource "aws_ecr_repository" "go-service" {
    name = "${var.cluster_name}-${var.env}"
    force_delete = true
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = false
    }
}


resource "aws_ecs_task_definition" "service" {
  family = "service"
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn
  cpu       = 1024
  memory    = 2048
  container_definitions = jsonencode([
    {
      name      = "goservice"
      image     = "nginx"  
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "goservice" {
  name            = "goservice"
  launch_type = "FARGATE"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 3
  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 50
  network_configuration {
    subnets = module.vpc.public_subnets
    security_groups = ["${aws_security_group.allow_tls.id}"]
    assign_public_ip = true
  }
  deployment_controller {
    type = "ECS"  #RollingUpdate
  }
}