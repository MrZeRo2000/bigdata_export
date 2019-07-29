module "int_dn_dim_payment_type" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_payment_type"
    stage = var.stage

    schema_columns = [
        { name = "payment_code", type = "string", comment = "" },
        { name = "payment_description", type = "string", comment = "" }
    ]
}