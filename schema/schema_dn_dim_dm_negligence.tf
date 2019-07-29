module "int_dn_dim_dm_negligence" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_negligence"
    stage = var.stage

    schema_columns = [
        { name = "dm_negligence_id", type = "double", comment = "negligence id" },
        { name = "dm_negligence_name", type = "string", comment = "negligence name" }
    ]
}