variable "environment" {  
}

variable "vpc_cidr" {
}

variable "public_subnet1_cidr" {
}

variable "public_subnet2_cidr" {
}

variable "region" {
    default = "us-east-2"
}

variable "tags" {
}

#ECS
variable "ecs_task_role" {
    description = "The ARN of IAM role"
    type        = string
    default     = ""
}

variable "ecs_task_execution_role" {
    description = "The ARN of IAM execution role"
    type        = string
    default     = ""
}

variable "public_subnet1_id" {
  type = string
  description = "ID of public subnet 1"
  default = ""
}

variable "public_subnet2_id" {
  type = string
  description = "ID of public subnet 2"
  default = ""
}

variable "ecs_fargate_sg" {
  type = string
  description = "ID of public subnet 2"
  default = ""
}