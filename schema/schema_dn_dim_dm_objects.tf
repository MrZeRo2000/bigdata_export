module "int_dn_dim_dm_objects" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_objects"
    stage = var.stage

    schema_columns = [
        { name = "dm_object_id", type = "double", comment = "COBSOFT.WSXTX.KBLO*100" },
        { name = "dm_object_name", type = "string", comment = "COBSOFT.WSXTX.KTEX" }
    ]
}