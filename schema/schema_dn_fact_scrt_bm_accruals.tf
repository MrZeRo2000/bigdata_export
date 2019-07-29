module "int_dn_fact_scrt_bm_accruals" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_scrt_bm_accruals"
    stage = var.stage

    schema_columns = [
        { name = "day_id", type = "string", comment = "Months of Bonus Minutes accurals" },
        { name = "customer_id", type = "double", comment = "The customer identifier  (dn_dim_customer_v2.customer_id) to whom the BM  was credited" },
        { name = "customer_no", type = "double", comment = "The customer identifier  (pametro.pidn) to whom the BM  was credited" },
        { name = "city_id", type = "double", comment = "Registration City identifier of Customer" },
        { name = "bm_reason_code", type = "string", comment = "Reason code of Bonus Minutes accurals" },
        { name = "bm_reason_description", type = "string", comment = "Reason description  of Bonus Minutes accurals" },
        { name = "bm_amount", type = "double", comment = "The amount of accrued Bonus Minutes" },
        { name = "accruals_date", type = "string", comment = "Date of Bonus Minutes accurals" },
        { name = "operator_number", type = "string", comment = "Operator internal number *BED who charged Customer with BM" },
        { name = "operator_name", type = "string", comment = "Operator name  who charged Customer with BM" },
        { name = "operator_city", type = "string", comment = "Operator Location city" },
        { name = "insert_date", type = "string", comment = "Date of inserted record" },
        { name = "bm_number", type = "double", comment = "Bonus minutes number" },
        { name = "bm_type", type = "string", comment = "Bonus minutes type" }
    ]
}