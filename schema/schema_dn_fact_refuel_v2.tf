module "int_dn_fact_refuel_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_refuel_v2"
    stage = var.stage

    schema_columns = [
        { name = "vehicle_id", type = "double", comment = "Vehicle ID; Source: DRIVENOW_BI.DN_DIM_VEHICLE_2.VEHICLE_ID" },
        { name = "source_record_id", type = "double", comment = "Autoincrement; Source: METRO.JV_CARS_REFUEL.RECORD_ID" },
        { name = "reservation_id", type = "double", comment = "Reservation Id; Source: METRO.JV_CARS_REFUEL.RECORD_ID" },
        { name = "vehicle_no", type = "double", comment = "Vehicle number used in METRO ( core ) system; Source: METRO.JVCARS.INT" },
        { name = "type_operation", type = "string", comment = "Type of a refuel - (C)harcge, (F)uel; Source: METRO.JVCARS.TYPE_OPERATION" },
        { name = "refuel_start_date", type = "string", comment = "Refuel start date; Source: METRO.JV_CARS_REFUEL" },
        { name = "refuel_end_date", type = "string", comment = "Refuel finish date; Source: METRO.JV_CARS_REFUEL" },
        { name = "tank_start_percentage", type = "double", comment = "Tank start volume in percent; Source: METRO.JV_CARS_REFUEL" },
        { name = "tank_end_percentage", type = "double", comment = "Tank start volume in percent; Source: METRO.JV_CARS_REFUEL" },
        { name = "city_id", type = "double", comment = "City; Source: calculated" },
        { name = "activity_date", type = "string", comment = "Data of a refual; METRO.JV_CARS_REFUEL.INSERT_DATE" },
        { name = "tech_insert_date", type = "string", comment = "Insert date; Source: SYSDATE" },
        { name = "customer_no", type = "double", comment = "Customer ID used in METRO ( core ) system; Source: METRO.PAMETRO.PIDN" },
        { name = "customer_id", type = "double", comment = "Customer ID; Source: DRIVENOW_BI.DN_DIM_CUSTOMER_V2.CUSTOMER_ID" },
        { name = "booking_id", type = "double", comment = "Booking ID; Source: METRO.JVRES.MVNR" },
        { name = "ccnr1", type = "string", comment = "First Card number for refuelling a car; Source: METRO.JVCAREQ.CCNR" },
        { name = "ccnr2", type = "string", comment = "Second Card number for refuelling a car; Source: METRO.JVCAREQ.CCNR" },
        { name = "tank_start_volume", type = "double", comment = "Tank start volume in litres; Source: METRO.JV_CARS_REFUEL" },
        { name = "tank_end_volume", type = "double", comment = "Tank end volume in litres; Source: METRO.JV_CARS_REFUEL" },
        { name = "battery_start_percentage", type = "double", comment = "Battery start percentage; Source: METRO.JV_CARS_REFUEL" },
        { name = "battery_end_percentage", type = "double", comment = "Battery end percentage; Source: METRO.JV_CARS_REFUEL" }
    ]
}