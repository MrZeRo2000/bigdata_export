module "int_dn_fact_scrt_inv_correction" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_scrt_inv_correction"
    stage = var.stage

    schema_columns = [
        { name = "customer_id", type = "double", comment = "" },
        { name = "city_id", type = "double", comment = "" },
        { name = "day_id", type = "string", comment = "" },
        { name = "booking_date", type = "string", comment = "" },
        { name = "booking_id", type = "double", comment = "" },
        { name = "bed_id", type = "double", comment = "" },
        { name = "bed_name", type = "string", comment = "" },
        { name = "adj_driving_min", type = "double", comment = "" },
        { name = "adj_parking_min", type = "double", comment = "" },
        { name = "adj_bonus_min", type = "double", comment = "" },
        { name = "adj_reservation_min", type = "double", comment = "" }
    ]
}