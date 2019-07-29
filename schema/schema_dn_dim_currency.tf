module "int_dn_dim_currency" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_currency"
    stage = var.stage

    schema_columns = [
        { name = "land", type = "string", comment = "Country Source SIXT.ISO" },
        { name = "land_iso", type = "string", comment = "Country ISO code Source SIXT.ISO" },
        { name = "land_currency", type = "string", comment = "Currency abbreviation Source SIXT.ALPARM" },
        { name = "dest_currency", type = "string", comment = "Destination currency abbreviation Source SIXT.SXWAEHR" },
        { name = "sdt", type = "string", comment = "Start date Source SIXT.SXWAEHR" },
        { name = "edt", type = "string", comment = "End date Source SIXT.SXWAEHR" },
        { name = "exchange_rate", type = "double", comment = "Exchange rate Source SIXT.SXWAEHR" }
    ]
}