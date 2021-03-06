module "int_dn_dim_customer_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_customer_v2"
    stage = var.stage

    schema_columns = [
        { name = "customer_no", type = "double", comment = "Customer ID used in METRO ( core ) system; Source: METRO.PAMETRO.PIDN" },
        { name = "customer_group_id", type = "double", comment = "Customer ID used in METRO ( core ) system; Source: METRO.PAMETRO" },
        { name = "role", type = "string", comment = "Customer role; Source: METRO.PAMETRO.ROLE" },
        { name = "entry_date", type = "string", comment = "Entry date; Source: METRO.PAMETRO.EIND" },
        { name = "exit_date", type = "string", comment = "Customer exit date. Source: METRO.PAMETRO.ENDD" },
        { name = "block_indicator", type = "double", comment = "Customer block indicator; Source: METRO.PAMETRO.MSKZ" },
        { name = "block_date", type = "string", comment = "Block date; Source: METRO.PAMETRO.MSDA" },
        { name = "customer_group", type = "string", comment = "Customer block indicator; Source: METRO.PAMETRO.NUTG" },
        { name = "newsletter", type = "string", comment = "Newsletter registration flag; Source: METRO.PAMETRO.JVNL" },
        { name = "bonus_account_state", type = "double", comment = "Saldo of a bonus minutes with usage type - private. Source: METRO.PAMETRO.BAS" },
        { name = "spontaneous_reservation", type = "string", comment = "Flag used to define the possability to do spontaneous reservation (Y - Operative cost centers; A - Without restriction(employee); N - Not Allowed; C - Restricted to Cost Centre; S - Only cars on service). Source: METRO.PAMETRO.SPRS" },
        { name = "parent_partner_id", type = "double", comment = "Parent ID (PIDN); Source: METRO.PAMETRO.PPAR" },
        { name = "parent_partner_role", type = "string", comment = "Parent role; Source: METRO.PAMETRO.ROLE" },
        { name = "language", type = "double", comment = "Default customer language; Source: METRO.JVIDENT.JVII" },
        { name = "registration_city_no", type = "double", comment = "City number of a customer registration; Source: METRO.PAMETRO.CIT" },
        { name = "promotion_code", type = "string", comment = "Promo code used by a customer; Source: METRO.PAMETRO.PRC" },
        { name = "external_employee_no", type = "string", comment = "External employee number e.g. activation/registration stations etc.. Source: METRO.PAMETRO.JVMN" },
        { name = "personal_promotion_code", type = "string", comment = "Personal promo code that can be used by other customers for registration; Source: METRO.PAMETRO.PPRC" },
        { name = "business_bonus_account_state", type = "double", comment = "Saldo of the bonus minutes with usage type - business. Source: METRO.PAMETRO.BASB" },
        { name = "zone_id", type = "double", comment = "Zone id of the PG, Airport etc.. Source: METRO.PAMETRO.ZONI" },
        { name = "billing_cost_center", type = "double", comment = "Billing cost center (for taxes). Source: METRO.PAMETRO.BILC" },
        { name = "other_title", type = "string", comment = "Other title of a person. Source: METRO.JVPERS.OTIT" },
        { name = "firstname", type = "string", comment = "First name; Source: METRO.JVPERS.VNAM" },
        { name = "surname", type = "string", comment = "Last name; Source: METRO.JVPERS.NNAM" },
        { name = "gender", type = "string", comment = "Gender; Source: METRO.JVPERS.GENDER" },
        { name = "new_edit_date", type = "string", comment = "Date before calculation date" },
        { name = "change_date", type = "string", comment = "Last change date of a customer in the METRO. Source: METRO.JVPERS.AEDA" },
        { name = "staff_number", type = "double", comment = "Internal user Id who has changed a customer (Example 7770777 is the internal tech user). Source: METRO.JVPERS.BED" },
        { name = "second_name", type = "string", comment = "Second name; Source: METRO.JVPERS.NAME3" },
        { name = "birth_date", type = "string", comment = "Birthday; Source: METRO.JVIDENT.BDAY" },
        { name = "birth_place", type = "string", comment = "Birthday; Source: METRO.JVIDENT.BPLA" },
        { name = "birth_country", type = "string", comment = "Birthday; Source: METRO.JVIDENT.BCNT" },
        { name = "country_state", type = "string", comment = "Deprecated. County State of an customer adress (ISO 3166 country codes - Alpha 2 code). Source: METRO.JVIDENT.FSS" },
        { name = "uuid", type = "string", comment = "Customer UUID; Source: METRO.JVIDENT.UUID" },
        { name = "private_latitude", type = "double", comment = "Latitude of a customer private address; Source: METRO.JVADR.LATU" },
        { name = "private_longtitude", type = "double", comment = "Longitude of a customer private address; Source: METRO.JVADR.LOTU" },
        { name = "business_latitude", type = "double", comment = "Latitude of a customer business address; Source: METRO.JVADR.LATU" },
        { name = "business_longtitude", type = "double", comment = "Longitude of a customer business address; Source: METRO.JVADR.LATU" },
        { name = "private_zip", type = "string", comment = "ZIP code of a customer private address; Source: METRO.JVADR.LATU" },
        { name = "private_house_no_1", type = "string", comment = "Private customer address" },
        { name = "private_street", type = "string", comment = "Private customer address" },
        { name = "private_post_office_box", type = "string", comment = "Private customer address" },
        { name = "private_city", type = "string", comment = "Private customer address" },
        { name = "private_country", type = "string", comment = "Private customer address" },
        { name = "customer_id", type = "double", comment = "Autoincrement value" },
        { name = "valid_from", type = "string", comment = "Validity start" },
        { name = "valid_to", type = "string", comment = "Validity end" },
        { name = "active_version", type = "double", comment = "Flag for active/last version (1)" },
        { name = "initial_activation_date", type = "string", comment = "Date when a customer was activated; Source: METRO.JVPERSATTR" },
        { name = "upload_date", type = "string", comment = "Calculation date" },
        { name = "date_first_drive", type = "string", comment = "Date of the first successful drive; Source: METRO.JVRES" },
        { name = "date_last_drive", type = "string", comment = "Date of the last successful drive; Source: METRO.JVRES" },
        { name = "days_reg_act", type = "double", comment = "Number of days between customer registration and activation" },
        { name = "days_reg_first_drive", type = "double", comment = "Number of days passed from a registration till first successful drive; Source: METRO.JVRES, METRO.PAMETRO" },
        { name = "days_act_first_drive", type = "double", comment = "Number of days passed from a first activation till first successful drive; Source: METRO.JVRES, METRO.PAMETLAP" },
        { name = "days_first_last_drive", type = "double", comment = "Number of days between two last drives; Source: METRO.JVRES" },
        { name = "days_today_last_drive", type = "double", comment = "Number of days between last drives and date of the dimension calculation (now); Source: METRO.JVRES" },
        { name = "drives_total", type = "double", comment = "Number of successful drives; Source: METRO.JVRES" },
        { name = "is_first_drive_null", type = "double", comment = "Do a customer already did his/her first drive (1/0); Source: METRO.JVRES" },
        { name = "ops_ins_flag", type = "string", comment = "Partner newsletter; Source: METRO.JVPERSATTR" },
        { name = "dl_check_status", type = "string", comment = "Status of a driver licence check process; Source: METRO.JVPERSATTR" },
        { name = "inside_area", type = "double", comment = "Is a customer lives inside a business area defined by METRO.JV_ZONE* tables" },
        { name = "business_customer_type", type = "double", comment = "Business customer type used for business. Possible values: 2 - COMPANY specific, 1 - SCY-specific, 3 - potential business customer, 9 - no business customer; Source: METRO.PAMETRO" },
        { name = "registration_company_no", type = "double", comment = "Company when a customer was registered; Source: DRIVENOW_BI.DN_DIM_FLEET.COMPANY_NO" },
        { name = "price_list", type = "string", comment = "Price list code of a promo code used during registration process; Source: DRIVENOW_BI.DN_DIM_PROMOTION" },
        { name = "price", type = "double", comment = "Registration price in local currency; Source: DRIVENOW_BI.DN_DIM_PROMOTION" },
        { name = "bonus_minutes", type = "double", comment = "Amount of bonus minutes gived with a used registration promo code; Source: DRIVENOW_BI.DN_DIM_PROMOTION.NUM_EVENTS" },
        { name = "num_events", type = "double", comment = "Number of rest promo events; Source: DRIVENOW_BI.DN_DIM_PROMOTION.NUM_EVENTS" },
        { name = "accounting_to", type = "string", comment = "Department to which promo code accounts; Source: DRIVENOW_BI.DN_DIM_PROMOTION" },
        { name = "customer_fuul_name", type = "string", comment = "Customer full name; Source: METRO.JVPERS" },
        { name = "promo_owner_name", type = "string", comment = "Owner/creater of a promo code; DRIVENOW_BI.DN_DIM_PROMOTION" },
        { name = "promo_valid_from", type = "string", comment = "Promo code validity start date; DRIVENOW_BI.DN_DIM_PROMOTION" },
        { name = "promo_valid_to", type = "string", comment = "Promo code validity end date; DRIVENOW_BI.DN_DIM_PROMOTION" },
        { name = "promocode_key", type = "string", comment = "Syntetic promo code key used to map with the DRIVENOW_BI.DN_DIM_PROMOTION" },
        { name = "dl_check_provider", type = "string", comment = "Driver licence check provider; Source: METRO.JVPERSATTR" },
        { name = "dl_issuing_country", type = "string", comment = "Driver licence issuing country; Source: METRO.JVPERSATTR" },
        { name = "dl_category", type = "string", comment = "Driver licence category ( 1-6 , defined by the configuration ); Source: METRO.JV_CONFIG" },
        { name = "sub_block_indicator", type = "double", comment = "Sub block indicator. For activated customers (mskz=2) possible values : : 0 - Able to drive; [1,3] - Unable to drive" },
        { name = "customer_status", type = "double", comment = "general customer status based on columns block_indicator and sub_block_indicator. Calculated as block_indicator * 10 + sub_block_indicator" },
        { name = "ops_ins_dn_flag", type = "string", comment = "DriveNow newsletter; Source: METRO.JVPERSATTR" },
        { name = "ops_ins_sixt_flag", type = "string", comment = "SIXT newsletter; Source: METRO.JVPERSATTR" },
        { name = "date_5_drive", type = "string", comment = "Date of a5th successful drive; Source: METRO.JVRES" },
        { name = "lpid", type = "string", comment = "Card number of customer; Source: METRO.PAMETLAP" },
        { name = "price_eur", type = "double", comment = "Registration price in EUR; Source: DN_DIM_PROMOTION" },
        { name = "original_currency", type = "string", comment = "Original currency" },
        { name = "corporate_id", type = "double", comment = "Internal identifier of Corporate linked to customer" }
    ]
}