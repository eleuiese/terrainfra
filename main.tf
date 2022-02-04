module "network" {
    source = "./src/modules/network"
    
    environment          = var.environment
    vpc_cidr             = var.vpc_cidr
    public_subnet1_cidr  = var.public_subnet1_cidr
    public_subnet2_cidr  = var.public_subnet2_cidr
    tags                 = var.tags
}

module "ecs" {
    source = "./src/modules/ecs"   
    ecs_task_role           = module.iam.ecs_task_role
    ecs_task_execution_role = module.iam.ecs_task_execution_role
    public_subnet1_id       = module.network.public_subnet1_id
    public_subnet2_id       = module.network.public_subnet2_id
    vpc_id                  = module.network.vpc_id
}

module "iam" {
    source = "./src/modules/iam"   
}




