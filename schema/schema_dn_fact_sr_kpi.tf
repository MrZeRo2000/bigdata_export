module "int_dn_fact_sr_kpi" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_sr_kpi"
    stage = var.stage

    schema_columns = [
        { name = "day_id", type = "string", comment = "Day" },
        { name = "city_id", type = "double", comment = "City identifier" },
        { name = "customer_id", type = "double", comment = "Customer identifier" },
        { name = "sr_kpi_code", type = "string", comment = "Internal KPI code" },
        { name = "sr_kpi_value", type = "double", comment = "KPI Value" },
        { name = "load_date_time", type = "string", comment = "Time when record is inserted" }
    ]
}