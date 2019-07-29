module "int_dn_dim_bm_types" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_bm_types"
    stage = var.stage

    schema_columns = [
        { name = "bm_type", type = "string", comment = "" },
        { name = "bm_type_name", type = "string", comment = "" }
    ]
}