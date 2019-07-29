module "int_dn_dim_dm_rpr_types" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_rpr_types"
    stage = var.stage

    schema_columns = [
        { name = "rpr_type_id", type = "double", comment = "COBSOFT.FPREPART.RART" },
        { name = "rpr_type_code", type = "string", comment = "FFP" },
        { name = "rpr_type_text", type = "string", comment = "COBSOFT.FPREPART.RTEX" }
    ]
}