module "int_dn_dim_dm_sides" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_sides"
    stage = var.stage

    schema_columns = [
        { name = "dm_side_id", type = "double", comment = "COBSOFT.WSXTX.KBLO" },
        { name = "dm_side_name", type = "string", comment = "COBSOFT.WSXTX.KTEX" }
    ]
}