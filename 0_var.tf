variable "region" {
  type = string
  default = "Korea Central"
}
variable "db_admin" {
  type = string
  default = "hamster"
}
variable "db_password" {
  type = string
  default = "q1q1q1q1q1q!"
}
variable "ssh_name" {
  type = string
  default = "azureuser"
}
variable "ssh_path" {
  type = string
  default = "../../../.ssh/id_rsa.pub"
}

variable "aks_service_principal_object_id" {
    description = "Object ID of the service principal."
      default = "a53e8350-e041-4629-97a0-1f42e486d5ae"
} # objectID

variable "aks_service_principal_app_id" {
    description = "Application ID/Client ID  of the service principal. Used by AKS to manage AKS related resources on Azure like vms, subnets."
      default = "fdecfeb9-b694-4912-85a5-bfa3670fcc39"
} # appID

variable "aks_service_principal_client_secret" {
    description = "Secret of the service principal. Used by AKS to manage Azure."
      default = "tV27pjBAlvZL06g1Bvdq3W4-1jX~7zz0kY"
} # password
variable "aks_AD_tenant_id" {
    description = "tenant_id"
      default = "df9bad6f-9a31-4eec-b9fa-f6955eae81bd"
} # tenant id

# az ad sp create-for-rbac -n kangtkapp --role="Contributor" --scopes="/subscriptions/73a1550d-83bd-4adf-95ba-142194c421f7"
# az ad sp list --display-name <displayname> | grep -i objectid