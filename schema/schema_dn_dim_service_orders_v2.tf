module "int_dn_dim_service_orders_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_service_orders_v2"
    stage = var.stage

    schema_columns = [
        { name = "id", type = "double", comment = "" },
        { name = "service_order_name", type = "string", comment = "" },
        { name = "technical_so_name", type = "string", comment = "" },
        { name = "price_list", type = "string", comment = "" },
        { name = "upload_date", type = "string", comment = "" }
    ]
}