module "int_dn_dict_prd_catalog_map" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dict_prd_catalog_map"
    stage = var.stage

    schema_columns = [
        { name = "id", type = "double", comment = "" },
        { name = "l1_id", type = "double", comment = "" },
        { name = "l2_id", type = "double", comment = "" },
        { name = "l3_id", type = "double", comment = "" },
        { name = "l4_id", type = "double", comment = "" },
        { name = "l5_id", type = "double", comment = "" },
        { name = "l6_id", type = "double", comment = "" },
        { name = "product_code", type = "string", comment = "" },
        { name = "charge_code", type = "string", comment = "" },
        { name = "price_list", type = "string", comment = "" },
        { name = "tenant_id", type = "double", comment = "" },
        { name = "fleet_code", type = "string", comment = "" },
        { name = "last_changed_date", type = "string", comment = "" },
        { name = "last_changed_person", type = "string", comment = "" },
        { name = "number_minutes", type = "double", comment = "" },
        { name = "is_extra", type = "double", comment = "" }
    ]
}