module "int_dn_fact_rental_unsuccess" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_rental_unsuccess"
    stage = var.stage

    schema_columns = [
        { name = "jvid", type = "double", comment = "" },
        { name = "reservation_status", type = "double", comment = "" },
        { name = "cancellation_status", type = "double", comment = "" },
        { name = "date_last_update", type = "string", comment = "" },
        { name = "date_reservation", type = "string", comment = "" },
        { name = "vehicle_no", type = "double", comment = "" },
        { name = "customer_no", type = "double", comment = "" },
        { name = "city", type = "double", comment = "" },
        { name = "vehicle_id", type = "double", comment = "" },
        { name = "customer_id", type = "double", comment = "" }
    ]
}