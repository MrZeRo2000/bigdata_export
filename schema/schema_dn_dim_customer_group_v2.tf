module "int_dn_dim_customer_group_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_customer_group_v2"
    stage = var.stage

    schema_columns = [
        { name = "customer_group_id", type = "double", comment = "" },
        { name = "group", type = "string", comment = "" },
        { name = "description", type = "string", comment = "" }
    ]
}