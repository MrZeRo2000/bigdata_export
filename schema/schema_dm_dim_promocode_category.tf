module "int_dm_dim_promocode_category" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dm_dim_promocode_category"
    stage = var.stage

    schema_columns = [
        { name = "category", type = "string", comment = "" },
        { name = "category_name", type = "string", comment = "" },
        { name = "insert_date", type = "string", comment = "" }
    ]
}
