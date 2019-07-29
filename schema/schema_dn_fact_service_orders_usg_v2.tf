module "int_dn_fact_service_orders_usg_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_service_orders_usg_v2"
    stage = var.stage

    schema_columns = [
        { name = "upload_date", type = "string", comment = "" },
        { name = "customer_id", type = "double", comment = "" },
        { name = "vehicle_id", type = "double", comment = "" },
        { name = "mandant_no", type = "double", comment = "" },
        { name = "start_city", type = "double", comment = "" },
        { name = "end_city", type = "double", comment = "" },
        { name = "vehicle_no", type = "double", comment = "" },
        { name = "vin", type = "string", comment = "" },
        { name = "license_plate", type = "string", comment = "" },
        { name = "service_order_id", type = "double", comment = "" },
        { name = "customer_no", type = "double", comment = "" },
        { name = "lpid", type = "string", comment = "" },
        { name = "booking_id", type = "double", comment = "" },
        { name = "res_status", type = "double", comment = "" },
        { name = "so_status", type = "string", comment = "" },
        { name = "reservation_date", type = "string", comment = "" },
        { name = "start_date", type = "string", comment = "" },
        { name = "end_date", type = "string", comment = "" },
        { name = "distance", type = "double", comment = "" },
        { name = "drive_duration", type = "double", comment = "" },
        { name = "driving_minutes", type = "double", comment = "" },
        { name = "parking_minutes", type = "double", comment = "" },
        { name = "technical_so_name", type = "string", comment = "" },
        { name = "start_address", type = "string", comment = "" },
        { name = "end_address", type = "string", comment = "" },
        { name = "start_lat", type = "double", comment = "" },
        { name = "start_lot", type = "double", comment = "" },
        { name = "end_lat", type = "double", comment = "" },
        { name = "end_lot", type = "double", comment = "" },
        { name = "start_garage_id", type = "double", comment = "" },
        { name = "end_garage_id", type = "double", comment = "" },
        { name = "technical_so_2_name", type = "string", comment = "" },
        { name = "user_name", type = "string", comment = "" },
        { name = "order_text", type = "string", comment = "" },
        { name = "next_reservation_date", type = "string", comment = "Reservation date after service order is completed" },
        { name = "idle_duration", type = "double", comment = "Idle Time after Service Order until next rental in hours" },
        { name = "lpid_empl", type = "string", comment = "LapId of Employee" },
        { name = "empl_name", type = "string", comment = "Name of Employee" }
    ]
}