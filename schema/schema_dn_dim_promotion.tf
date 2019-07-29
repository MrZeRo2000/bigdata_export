module "int_dn_dim_promotion" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_promotion"
    stage = var.stage

    schema_columns = [
        { name = "promotion_id", type = "double", comment = "Autoincrement value" },
        { name = "promotion_code", type = "string", comment = "Promo code; Source: METRO.JVPROMO.PRC" },
        { name = "company_no", type = "double", comment = "Country to which promo code belongs to; Source: METRO.JVPROMO.FIR" },
        { name = "valid_from", type = "string", comment = "Validity start" },
        { name = "valid_to", type = "string", comment = "Validity end" },
        { name = "price_list", type = "string", comment = "Price list code used for a promo code; Source: METRO.JVPROMO.PRC" },
        { name = "price", type = "double", comment = "Promo code price; Source: SIXT" },
        { name = "bonus_minutes", type = "double", comment = "Amount of bonus minutes by promo code; Source: METRO.JVPROMO.BON" },
        { name = "num_events", type = "double", comment = "Number of rest promo events; Source: METRO.JVPROMO.ANZ" },
        { name = "accounting_to", type = "string", comment = "Department to which promo code accounts; Source: METRO.JVPROMO.ACCO" },
        { name = "change_date_time", type = "string", comment = "Calculation date" },
        { name = "owner_name", type = "string", comment = "Owner/creater of a promo code; METRO.JVPROMO.NAM" }
    ]
}