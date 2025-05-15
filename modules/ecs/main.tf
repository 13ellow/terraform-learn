resource "aws_ecs_cluster" "ecs-cluster" {
    name = "terraform-ecs-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "ecs-capacity-provider" {
    cluster_name = aws_ecs_cluster.ecs-cluster.name
    capacity_providers = ["FARGATE"]

    default_capacity_provider_strategy {
      base = 3
      weight = 6
      capacity_provider = "FARGATE"
    }
}

resource "aws_ecs_service" "ecs-service-front" {
  name = "terraform-ecs-service"
  cluster = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-task-front.arn
  desired_count = 2

  # ELBを使用している際のヘルスチェック失敗によるタスクのシャットダウンを無視する秒数
  health_check_grace_period_seconds = 60

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = "front"
    container_port = 80
  }
}

resource "aws_ecs_task_definition" "ecs-task-front" {
    family = "ecs-task-definition"
    container_definitions = file("task-definitions/definition.json")

}