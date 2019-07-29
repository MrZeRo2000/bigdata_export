module "int_dn_fact_prd_usage_details_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_prd_usage_details_v2"
    stage = var.stage

    schema_columns = [
        { name = "id", type = "double", comment = "Autoincrement value" },
        { name = "customer_id", type = "double", comment = "Customer ID; Source: DRIVENOW_BI.DN_DIM_CUSTOMER_V2.CUSTOMER_ID" },
        { name = "vehicle_id", type = "double", comment = "Vehicle ID; Source: DRIVENOW_BI.DN_DIM_VEHICLE_2.VEHICLE_ID" },
        { name = "tenant_id", type = "double", comment = "Tenant Id when a product was used; Source: calculated" },
        { name = "fleet_code", type = "string", comment = "Customer fleet; Source: METRO.PAMETRO.CIT" },
        { name = "usage_code", type = "string", comment = "Type of the product usage: (P)rivate, (B)usiness; Source: METRO.RAMETRO.GPRI" },
        { name = "customer_no", type = "double", comment = "Customer ID used in METRO ( core ) system; Source: METRO.PAMETRO.PIDN" },
        { name = "booking_id", type = "double", comment = "Booking ID; Source: METRO.{RAMETRO|JVRES}.MVNR" },
        { name = "booking_date", type = "string", comment = "Booking date; Source: SIXT.RARENT.AEDA" },
        { name = "vehicle_no", type = "double", comment = "Vehicle number used in METRO ( core ) system; Source: METRO.JVCARS.INT" },
        { name = "vehicle_tenant", type = "double", comment = "Vehicle tenant; Source: DRIVENOW_BI.DN_DIM_VEHICLE_2" },
        { name = "l1_id", type = "double", comment = "Id of the 1 level of the product tree; Source: DRIVENOW_BI.DN_DIM_PRD_CATALOG_L1.ID" },
        { name = "l2_id", type = "double", comment = "Id of the 2 level of the product tree; Source: DRIVENOW_BI.DN_DIM_PRD_CATALOG_L2.ID" },
        { name = "l3_id", type = "double", comment = "Id of the 3 level of the product tree; Source: DRIVENOW_BI.DN_DIM_PRD_CATALOG_L3.ID" },
        { name = "l4_id", type = "double", comment = "Id of the 4 level of the product tree; Source: DRIVENOW_BI.DN_DIM_PRD_CATALOG_L4.ID" },
        { name = "l5_id", type = "double", comment = "Id of the 5 level of the product tree; Source: DRIVENOW_BI.DN_DIM_PRD_CATALOG_L5.ID" },
        { name = "l6_id", type = "double", comment = "Id of the 6 level of the product tree; Source: DRIVENOW_BI.DN_DIM_PRD_CATALOG_L6.ID" },
        { name = "is_roaming", type = "double", comment = "Is a product was used in the roaming; Source: calculated" },
        { name = "correction_number", type = "double", comment = "Number of the last correction; Source: SIXT.RAINV.KONR" },
        { name = "number_of_events", type = "double", comment = "Number of times product was used; Source: SIXT.RACHARGE.ANZ1" },
        { name = "amount_minutes", type = "double", comment = "Number of minutes; Source: calculated" },
        { name = "income_netto", type = "double", comment = "Netto amount; Source: SIXT.RACHARGE.BET1" },
        { name = "tax_level", type = "double", comment = "Tax level; Source: SIXT.RACHARGE.PST1" },
        { name = "start_date", type = "string", comment = "Date of start product usage; Source: calculated" },
        { name = "end_date", type = "string", comment = "Date of end produst usage; Source: calculated" },
        { name = "source_insert_date", type = "string", comment = "Insert date; Source: SYSDATE" },
        { name = "dict_id", type = "double", comment = "Dictionary ID; Source: DRIVENOW_BI.DN_DICT_PRD_CATALOG_MAP.ID" },
        { name = "charge_code", type = "string", comment = "Charge code; Source: SIXT.RACHARGE.CHCO" },
        { name = "invoice_type", type = "string", comment = "Invoice type (M)ain or (S)econdary; Source: SIXT.RAINV.INTY" },
        { name = "metro_invoice_type", type = "string", comment = "Metro invoce type (R)ental, (P)repaid package, M - Registration; Source: METRO.RAMETRO.JVRT" },
        { name = "start_city", type = "double", comment = "City where usage of a product was begun; Source: METRO.RAMETRO.JUCI" },
        { name = "return_city", type = "double", comment = "City where usage of a product was finished; Source: METRO.RAMETRO.JRCI" },
        { name = "start_km_level", type = "double", comment = "Current kilometers level at the start of a rental; Source: METRO.RAMETRO.AKKO" },
        { name = "end_km_level", type = "double", comment = "Current kilometers level at the end of a rental; Source: METRO.RAMETRO.AKKI" },
        { name = "payment_type", type = "string", comment = "Payment type; Source: SIXT.RAINV.ZAH" },
        { name = "country_currency", type = "string", comment = "Country currency; Source: SIXT.RAINV.HEWA" },
        { name = "rental_currency", type = "string", comment = "Rental currency; Source: SIXT.RAINV.WAKZ" },
        { name = "exchange_rate", type = "double", comment = "Exchange rate; Source: DRIVENOW_BI.DN_DIM_EXCHANGE_RATE_V2.EXCHANGE_RATE" },
        { name = "mandant_no", type = "double", comment = "Mandant no of a city where usage of a product was finished; Source: DRIVENOW_BI.DN_DIM_FLEET_V2.COMPANY_NO" },
        { name = "load_date_time", type = "string", comment = "Insert date; Source: SYSDATE" },
        { name = "start_lat", type = "double", comment = "Start latitude; Source: METRO.RAMETRO.LATO" },
        { name = "start_lot", type = "double", comment = "Start longitude; Source: METRO.RAMETRO.LOTO" },
        { name = "end_lat", type = "double", comment = "End latitude; Source: METRO.RAMETRO.LATI" },
        { name = "end_lot", type = "double", comment = "End longitude; Source: METRO.RAMETRO.LOTI" },
        { name = "start_garage_id", type = "double", comment = "Garage Id were journey was started; Source: METRO.RAMETRO.OPG" },
        { name = "end_garage_id", type = "double", comment = "Garage Id were journey was finished; Source: METRO.RAMETRO.IPG" },
        { name = "km_duration", type = "double", comment = "Munber of kilometers for a product; Source: calculated" },
        { name = "customer_exit_date", type = "string", comment = "Customer exit date; Source: DRIVENOW_BI.DN_DIM_CUSTOMER_V2.EXIT_DATE" },
        { name = "fleet_id", type = "string", comment = "Fleet Id of a city where usage of a product was finished; Source: DRIVENOW_BI.DN_DIM_FLEET_V2.FLEET_ID" },
        { name = "price_id", type = "double", comment = "Price id; Source: DRIVENOW_BI.DN_DIM_CURRENCY.SDT || CITY_ID)" },
        { name = "price_exchange_rate", type = "double", comment = "Source: DRIVENOW_BI.DN_DIM_CURRENCY.EXCHANGE_RATE" },
        { name = "net_amount_eur", type = "double", comment = "Net amount in Euro; Source: calculated" },
        { name = "added_minutes", type = "double", comment = "Number of added minutes ( for CHARGE_CODE = QC is always AMOUNT_MINUTES ); Source: calculated" },
        { name = "is_corrected", type = "string", comment = "Is an invoice was corrected; Source: calculated" },
        { name = "is_drive", type = "double", comment = "Is an invoice is (R)ental; Source: calculated" },
        { name = "orig_cur", type = "string", comment = "Original currency of an invoice; Source: SIXT.RAINV.WAKZ" },
        { name = "vat_amount_orig_cur", type = "double", comment = "Vat amount in original currency; Source: calculated" },
        { name = "vat_amount_eur", type = "double", comment = "Vat amount in Euro; Source: calculated" },
        { name = "kilometers", type = "double", comment = "Munber of kilometers for a product; Source: calculated" },
        { name = "minutes", type = "double", comment = "Number of minutes ( for CHARGE_CODE = QC is always 0 ); Source: calculated" },
        { name = "city_airport_key", type = "string", comment = "Syntetic key for airport dimension; Source: DRIVENOW_BI.DN_DIM_AIRPORT_CITY_MAPPING.CITY_AIRPORT_KEY" },
        { name = "airport_garage_id", type = "double", comment = "Airport ID; Source: METRO.JVRES.{OPG|IPG}" },
        { name = "is_end_at_airport", type = "double", comment = "Is a rent was finished at airport; Source: calculated" },
        { name = "is_start_at_airport", type = "double", comment = "Is a rent was started at airport; Source: calculated" },
        { name = "fact_type", type = "string", comment = "Type of the fact, used in app; Source: calculated" },
        { name = "rate_id", type = "double", comment = "Rate Id; Source: DRIVENOW_BI.DN_DIM_RATE.RATE_ID" },
        { name = "voucher_usage_type", type = "double", comment = "Show info about which type of Voucher is used; Source: calculated" }
    ]
}