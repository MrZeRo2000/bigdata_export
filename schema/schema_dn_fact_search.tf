module "int_dn_fact_search" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_search"
    stage = var.stage

    schema_columns = [
        { name = "search_id", type = "double", comment = "" },
        { name = "search_date", type = "string", comment = "" },
        { name = "city", type = "double", comment = "" },
        { name = "fleet_id", type = "string", comment = "" },
        { name = "customer_no", type = "double", comment = "" },
        { name = "customer_id", type = "double", comment = "" },
        { name = "reservation_id", type = "double", comment = "" },
        { name = "number_100", type = "double", comment = "" },
        { name = "number_200", type = "double", comment = "" },
        { name = "number_300", type = "double", comment = "" },
        { name = "number_400", type = "double", comment = "" },
        { name = "number_500", type = "double", comment = "" },
        { name = "number_600", type = "double", comment = "" },
        { name = "distance", type = "double", comment = "" },
        { name = "change_date_time", type = "string", comment = "" },
        { name = "latu", type = "double", comment = "Search latitude" },
        { name = "lotu", type = "double", comment = "Search longitude" },
        { name = "near_airport", type = "double", comment = "Represents minimum radius where no vehicles were found ( in meters )" },
        { name = "no_veh_in_radius", type = "double", comment = "" }
    ]
}