#this is datbricks workspace url output
output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.workspace.workspace_url}/"
}

#this is databricks cluster node type
output "databricks_node_type" {
  value = databricks_cluster.shared_autoscaling.node_type_id
}

#this is databricks cluster spark version
output "databricks__spark_version" {
  value = databricks_cluster.shared_autoscaling.spark_version
}
