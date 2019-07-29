module "int_dn_fact_offer" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_offer"
    stage = var.stage

    schema_columns = [
        { name = "day_id", type = "string", comment = "" },
        { name = "offer_id", type = "double", comment = "" },
        { name = "city_id", type = "double", comment = "" },
        { name = "fleet_id", type = "string", comment = "" },
        { name = "vehicle_no", type = "double", comment = "" },
        { name = "vehicle_id", type = "double", comment = "" },
        { name = "promocode", type = "string", comment = "" },
        { name = "process_badge", type = "string", comment = "" },
        { name = "valid_from", type = "string", comment = "" },
        { name = "valid_to", type = "string", comment = "" },
        { name = "change_date_time", type = "string", comment = "" }
    ]
}