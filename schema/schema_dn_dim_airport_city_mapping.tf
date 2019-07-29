module "int_dn_dim_airport_city_mapping" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_airport_city_mapping"
    stage = var.stage

    schema_columns = [
        { name = "company_no", type = "double", comment = "" },
        { name = "fleet_id", type = "string", comment = "" },
        { name = "city_id", type = "double", comment = "" },
        { name = "garage_id", type = "double", comment = "" },
        { name = "city_airport_key", type = "string", comment = "" },
        { name = "aita_code", type = "string", comment = "" }
    ]
}