resource "azurerm_resource_group" "RG-Terraform" {
  name     = "gmcterraform-rg"
  location = "canadacentral"
}

resource "azurerm_app_service_plan" "ASP-TerraForm" {
  name                = "gmcterraform-asp"
  location            = azurerm_resource_group.RG-Terraform.location
  resource_group_name = azurerm_resource_group.RG-Terraform.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "AS-Terraform" {
  name                = "gmcterraform-webapp"
  location            = azurerm_resource_group.RG-Terraform.location
  resource_group_name = azurerm_resource_group.RG-Terraform.name
  app_service_plan_id = azurerm_app_service_plan.ASP-TerraForm.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.terraform-sqlserver.fully_qualified_domain_name} Database=${azurerm_sql_database.terraform-sqldatabase.name};User ID=${azurerm_sql_server.terraform-sqlserver.administrator_login};Password=${azurerm_sql_server.terraform-sqlserver.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
  }
}

resource "azurerm_sql_server" "terraform-sqlserver" {
  name                         = "gmcterraform-sql"
  resource_group_name          = azurerm_resource_group.RG-Terraform.name
  location                     = azurerm_resource_group.RG-Terraform.location
  version                      = "12.0"
  administrator_login          = "morcodou"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_sql_database" "terraform-sqldatabase" {
  name                = "gmcterraform-db"
  resource_group_name = azurerm_resource_group.RG-Terraform.name
  location            = azurerm_resource_group.RG-Terraform.location
  server_name         = azurerm_sql_server.terraform-sqlserver.name

  tags = {
    environment = "dev"
  }
}