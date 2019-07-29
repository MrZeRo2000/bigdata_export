module "int_dn_dim_chargecode_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_chargecode_v2"
    stage = var.stage

    schema_columns = [
        { name = "booking_file_id", type = "double", comment = "" },
        { name = "charge_code", type = "string", comment = "" },
        { name = "valid_from", type = "string", comment = "" },
        { name = "valid_to", type = "string", comment = "" },
        { name = "point_of_definition", type = "string", comment = "" },
        { name = "description", type = "string", comment = "" },
        { name = "ensurance", type = "string", comment = "" },
        { name = "vatable", type = "string", comment = "" },
        { name = "discountable", type = "string", comment = "" },
        { name = "commisionable", type = "string", comment = "" },
        { name = "system_calculated", type = "string", comment = "" },
        { name = "included_in_estimated_total", type = "string", comment = "" },
        { name = "not_permitted_if_coi", type = "string", comment = "" },
        { name = "internet_appearance", type = "string", comment = "" },
        { name = "sorting", type = "double", comment = "" },
        { name = "one_way", type = "string", comment = "" },
        { name = "base_for_surcharge", type = "string", comment = "" }
    ]
}