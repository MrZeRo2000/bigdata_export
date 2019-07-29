module "int_dn_fact_vehicle_relocation" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_vehicle_relocation"
    stage = var.stage

    schema_columns = [
        { name = "load_date_time", type = "string", comment = "Insert date; Source: SYSDATE" },
        { name = "vehicle_id", type = "double", comment = "Vehicle ID; Source: METRO.JVRES.INT" },
        { name = "vehicle_no", type = "double", comment = "Vehicle number used in METRO ( core ) system; Source: METRO.CARS.INT" },
        { name = "day_id", type = "string", comment = "Day Id" },
        { name = "start_city_id", type = "double", comment = "Start city; Source: METRO.RAMETRO.JUCI" },
        { name = "start_jcst", type = "string", comment = "Start city type; Source: METRO.CITY.JCST" },
        { name = "end_city_id", type = "double", comment = "End city; Source: METRO.RAMETRO.JUCI" },
        { name = "end_jcst", type = "string", comment = "End city type; Source: METRO.CITY.JCST" },
        { name = "activity_type", type = "string", comment = "Activity type; Source: calculated" },
        { name = "vehicle_status", type = "string", comment = "Vehicle status; Source: METRO.JVCARS.AMPL" },
        { name = "next_vehicle_status", type = "string", comment = "Next vehicle status; Source: METRO.JVCARS.AMPL" },
        { name = "status", type = "string", comment = "Status; Source: calculated" },
        { name = "duration", type = "double", comment = "Number of seconds" },
        { name = "minutes", type = "double", comment = "Number of minutes; Source: round(DURATION/60)" },
        { name = "activity_type_new", type = "string", comment = "Use for additional status for Servise block event; Source: calculated" }
    ]
}