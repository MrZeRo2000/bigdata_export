module "int_dn_dim_dm_strength" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_strength"
    stage = var.stage

    schema_columns = [
        { name = "dm_strength_id", type = "double", comment = "COBSOFT.WSXTX.KBLO" },
        { name = "dm_strength_name", type = "string", comment = "COBSOFT.WSXTX.KTEX" }
    ]
}