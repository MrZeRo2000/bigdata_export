module "int_dn_dim_rate" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_rate"
    stage = var.stage

    schema_columns = [
        { name = "rate_id", type = "double", comment = "Rate Id. Autoincrement value" },
        { name = "rate_code", type = "string", comment = "Rate code; Source: SIXT" },
        { name = "vehicle_group", type = "string", comment = "Vehicle group; Source: SIXT" },
        { name = "charge_code", type = "string", comment = "Charge code; Source: SIXT" },
        { name = "rate_netto", type = "double", comment = "Rate netto amount; Source: SIXT" },
        { name = "rate_number", type = "double", comment = "Rate number; Source: SIXT" },
        { name = "valid_from", type = "string", comment = "Validity start" },
        { name = "valid_to", type = "string", comment = "Validity end" },
        { name = "load_date_time", type = "string", comment = "Load date" }
    ]
}