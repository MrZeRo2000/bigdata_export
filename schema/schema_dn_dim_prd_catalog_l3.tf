module "int_dn_dim_prd_catalog_l3" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_prd_catalog_l3"
    stage = var.stage

    schema_columns = [
        { name = "id", type = "double", comment = "" },
        { name = "name", type = "string", comment = "" },
        { name = "parent_id", type = "double", comment = "" },
        { name = "last_changed_date", type = "string", comment = "" },
        { name = "last_changed_person", type = "string", comment = "" },
        { name = "order_id", type = "double", comment = "" },
        { name = "internal_code", type = "string", comment = "" }
    ]
}