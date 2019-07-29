module "int_dn_fact_aggr_customer" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_aggr_customer"
    stage = var.stage

    schema_columns = [
        { name = "day_id", type = "string", comment = "" },
        { name = "city_id", type = "double", comment = "" },
        { name = "block_indicator", type = "double", comment = "" },
        { name = "sub_block_indicator", type = "double", comment = "" },
        { name = "gender", type = "string", comment = "" },
        { name = "age", type = "double", comment = "" },
        { name = "is_official", type = "double", comment = "" },
        { name = "num_customers", type = "double", comment = "" },
        { name = "load_date_time", type = "string", comment = "" }
    ]
}