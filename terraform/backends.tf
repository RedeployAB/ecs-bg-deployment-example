terraform {
  cloud {
    organization = "<CHANGE-ME>"

    workspaces {
      name = "ecs-bg-deployment-example"
    }
  }
}
