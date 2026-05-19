resource "railway_project" "task_flow" {
  name        = "TASK-FLOW-LINUX"
  description = "Infrastructure Task Flow"
}

resource "railway_database" "mysql_db" {
  project_id = railway_project.task_flow.id
  name       = "todolist-db"
  plugin     = "mysql"
}

resource "railway_service" "backend" {
  project_id = railway_project.task_flow.id
  name       = "task-flow-backend"
  
  source {
    repo           = "Lazaar200/TASK-FLOW-LINUX"
    root_directory = "backend"
  }
}

resource "railway_service" "frontend" {
  project_id = railway_project.task_flow.id
  name       = "task-flow-frontend"
  
  source {
    repo           = "Lazaar200/TASK-FLOW-LINUX"
    root_directory = "frontend"
  }
}
