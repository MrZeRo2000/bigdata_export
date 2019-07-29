module "int_dn_fact_scrt_inv_correction_fi" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_scrt_inv_correction_fi"
    stage = var.stage

    schema_columns = [
        { name = "customer_id", type = "double", comment = "Unique identifirer of customer refer to invoice number" },
        { name = "city_id", type = "double", comment = "City where invoice made" },
        { name = "day_id", type = "string", comment = "Date when invoice made" },
        { name = "booking_id", type = "double", comment = "Invoive number" },
        { name = "correction_number", type = "double", comment = "Correction number" },
        { name = "original_amount", type = "double", comment = "Original amoun of invoice (first version)" },
        { name = "currency_code", type = "string", comment = "Currency code" },
        { name = "amount_after_correction", type = "double", comment = "Total amoun of invoice afrer correction " },
        { name = "fin_impact", type = "double", comment = "Financial impact (ORIGINAL_AMOUNT - AMOUNT_AFTER_CORRECTION)" },
        { name = "load_date", type = "string", comment = "Load date of record" }
    ]
}