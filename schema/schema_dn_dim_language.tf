module "int_dn_dim_language" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_language"
    stage = var.stage

    schema_columns = [
        { name = "language_code", type = "string", comment = "Language code" },
        { name = "language_name", type = "string", comment = "Language name" },
        { name = "load_date", type = "string", comment = "Insert date" }
    ]
}