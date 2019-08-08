module "int_dn_fact_deleted_corr_invoices" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_deleted_corr_invoices"
    stage = var.stage

    schema_columns = [
        { name = "id", type = "double", comment = "" },
        { name = "customer_id", type = "double", comment = "" },
        { name = "vehicle_id", type = "double", comment = "" },
        { name = "tenant_id", type = "double", comment = "" },
        { name = "fleet_code", type = "string", comment = "" },
        { name = "usage_code", type = "string", comment = "" },
        { name = "customer_no", type = "double", comment = "" },
        { name = "booking_id", type = "double", comment = "" },
        { name = "booking_date", type = "string", comment = "" },
        { name = "vehicle_no", type = "double", comment = "" },
        { name = "vehicle_tenant", type = "double", comment = "" },
        { name = "l1_id", type = "double", comment = "" },
        { name = "l2_id", type = "double", comment = "" },
        { name = "l3_id", type = "double", comment = "" },
        { name = "l4_id", type = "double", comment = "" },
        { name = "l5_id", type = "double", comment = "" },
        { name = "l6_id", type = "double", comment = "" },
        { name = "is_roaming", type = "double", comment = "" },
        { name = "correction_number", type = "double", comment = "" },
        { name = "number_of_events", type = "double", comment = "" },
        { name = "amount_minutes", type = "double", comment = "" },
        { name = "income_netto", type = "double", comment = "" },
        { name = "tax_level", type = "double", comment = "" },
        { name = "start_date", type = "string", comment = "" },
        { name = "end_date", type = "string", comment = "" },
        { name = "source_insert_date", type = "string", comment = "" },
        { name = "dict_id", type = "double", comment = "" },
        { name = "charge_code", type = "string", comment = "" },
        { name = "invoice_type", type = "string", comment = "" },
        { name = "metro_invoice_type", type = "string", comment = "" },
        { name = "start_city", type = "double", comment = "" },
        { name = "return_city", type = "double", comment = "" },
        { name = "start_km_level", type = "double", comment = "" },
        { name = "end_km_level", type = "double", comment = "" },
        { name = "payment_type", type = "string", comment = "" },
        { name = "country_currency", type = "string", comment = "" },
        { name = "rental_currency", type = "string", comment = "" },
        { name = "exchange_rate", type = "double", comment = "" },
        { name = "mandant_no", type = "double", comment = "" },
        { name = "load_date_time", type = "string", comment = "" },
        { name = "start_lat", type = "double", comment = "" },
        { name = "start_lot", type = "double", comment = "" },
        { name = "end_lat", type = "double", comment = "" },
        { name = "end_lot", type = "double", comment = "" },
        { name = "start_garage_id", type = "double", comment = "" },
        { name = "end_garage_id", type = "double", comment = "" },
        { name = "insert_date", type = "string", comment = "" }
    ]
}
