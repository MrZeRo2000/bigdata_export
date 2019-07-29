module "int_dn_dim_product_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_product_v2"
    stage = var.stage

    schema_columns = [
        { name = "product_code", type = "string", comment = "" },
        { name = "price_list_code", type = "string", comment = "" },
        { name = "promo_mandant_no", type = "double", comment = "" },
        { name = "promo_start_date", type = "string", comment = "" },
        { name = "promo_start_time", type = "double", comment = "" },
        { name = "promo_end_date", type = "string", comment = "" },
        { name = "promo_end_time", type = "double", comment = "" },
        { name = "promobonus_minutes", type = "double", comment = "" },
        { name = "promo_info", type = "string", comment = "" },
        { name = "promo_type", type = "string", comment = "" },
        { name = "promo_single_price_of_rate", type = "double", comment = "" },
        { name = "promo_currency", type = "string", comment = "" },
        { name = "promo_zip", type = "string", comment = "" },
        { name = "promo_addon_charge", type = "string", comment = "" },
        { name = "promo_days_of_week", type = "string", comment = "" },
        { name = "promo_bonus_validity_days", type = "double", comment = "" },
        { name = "usage_private_business", type = "string", comment = "" },
        { name = "promo_partner_program", type = "string", comment = "" },
        { name = "jvem", type = "string", comment = "" },
        { name = "promo_employee_check_pattern", type = "string", comment = "" },
        { name = "promo_city_cost_center", type = "double", comment = "" },
        { name = "product_operation_type", type = "double", comment = "" },
        { name = "product_parent_id", type = "double", comment = "" },
        { name = "product_partner_id", type = "double", comment = "" },
        { name = "product_name", type = "string", comment = "" },
        { name = "product_priority", type = "double", comment = "" },
        { name = "product_pricing_derivate", type = "string", comment = "" },
        { name = "product_type", type = "string", comment = "" },
        { name = "product_seq_number", type = "double", comment = "" },
        { name = "product_id", type = "double", comment = "" },
        { name = "product_drop_off_zones", type = "string", comment = "" },
        { name = "product_stoprentalfee", type = "string", comment = "" },
        { name = "product_price", type = "string", comment = "" },
        { name = "product_product_code", type = "string", comment = "" },
        { name = "product_subcode", type = "string", comment = "" },
        { name = "product_kilometer", type = "string", comment = "" },
        { name = "product_minutes", type = "string", comment = "" },
        { name = "product_persons", type = "string", comment = "" },
        { name = "product_inform_partner_email", type = "string", comment = "" },
        { name = "product_min_drive_duration", type = "string", comment = "" },
        { name = "partner_product_sold_de", type = "string", comment = "" },
        { name = "product_shopping_sum", type = "string", comment = "" },
        { name = "product_discount", type = "string", comment = "" },
        { name = "product_bonus_park_mins", type = "string", comment = "" },
        { name = "partner_product_sold_en", type = "string", comment = "" },
        { name = "product_night", type = "string", comment = "" },
        { name = "product_paid_days", type = "string", comment = "" },
        { name = "product_checkforcredit", type = "string", comment = "" },
        { name = "product_min_minutes", type = "string", comment = "" },
        { name = "product_max_minutes", type = "string", comment = "" },
        { name = "product_max_length", type = "string", comment = "" },
        { name = "product_fleet_id", type = "string", comment = "" },
        { name = "product_valid_from", type = "string", comment = "" },
        { name = "product_valid_to", type = "string", comment = "" },
        { name = "product_time_pattern", type = "string", comment = "" },
        { name = "rate_code", type = "string", comment = "" }
    ]
}