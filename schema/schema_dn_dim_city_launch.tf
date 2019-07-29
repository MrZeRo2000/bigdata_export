module "int_dn_dim_city_launch" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_city_launch"
    stage = var.stage

    schema_columns = [
        { name = "city_id", type = "double", comment = "" },
        { name = "launch_date", type = "string", comment = "" },
        { name = "insert_date", type = "string", comment = "" }
    ]
}