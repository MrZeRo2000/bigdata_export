module "int_dn_dim_airport_iata_code" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_airport_iata_code"
    stage = var.stage

    schema_columns = [
        { name = "garage_id", type = "double", comment = "" },
        { name = "aita_code", type = "string", comment = "" },
        { name = "airport_description", type = "string", comment = "" },
        { name = "insert_date", type = "string", comment = "" }
    ]
}