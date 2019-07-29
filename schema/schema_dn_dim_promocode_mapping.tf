module "int_dn_dim_promocode_mapping" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_promocode_mapping"
    stage = var.stage

    schema_columns = [
        { name = "promocode", type = "string", comment = "Promocode" },
        { name = "promocode_description", type = "string", comment = "Promocode description" },
        { name = "category", type = "string", comment = "Promocode category" },
        { name = "subcategory", type = "string", comment = "Promocode subcategory" },
        { name = "promocode_key", type = "string", comment = "Promocode key" }
    ]
}