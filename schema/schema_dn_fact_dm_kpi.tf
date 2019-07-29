module "int_dn_fact_dm_kpi" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_dm_kpi"
    stage = var.stage

    schema_columns = [
        { name = "day_id", type = "string", comment = "Day" },
        { name = "city_id", type = "double", comment = "City  identifier" },
        { name = "dm_kpi_code", type = "string", comment = "Internal KPI code for  Damages" },
        { name = "dm_kpi_value", type = "double", comment = "KPI Value" },
        { name = "load_date_time", type = "string", comment = "Time when record is inserted" }
    ]
}