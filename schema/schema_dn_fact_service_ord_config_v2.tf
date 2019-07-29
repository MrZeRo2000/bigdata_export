module "int_dn_fact_service_ord_config_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_service_ord_config_v2"
    stage = var.stage

    schema_columns = [
        { name = "id", type = "double", comment = "" },
        { name = "customer_no", type = "double", comment = "" },
        { name = "start_date", type = "string", comment = "" },
        { name = "end_date", type = "string", comment = "" },
        { name = "technical_so_name", type = "string", comment = "" },
        { name = "start_city", type = "double", comment = "" },
        { name = "end_city", type = "double", comment = "" },
        { name = "block_time", type = "double", comment = "" },
        { name = "price_list", type = "string", comment = "" },
        { name = "upload_date", type = "string", comment = "" }
    ]
}