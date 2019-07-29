module "int_dn_dim_corp_customer" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_corp_customer"
    stage = var.stage

    schema_columns = [
        { name = "customer_no", type = "double", comment = "Customer number" },
        { name = "company_name", type = "string", comment = "Company name" },
        { name = "entry_date", type = "string", comment = "Corporate account creation date" },
        { name = "creator", type = "string", comment = "Corporate account creator" },
        { name = "accounting_to", type = "string", comment = "Accounting to" },
        { name = "city_name", type = "string", comment = "City" },
        { name = "promotion_code", type = "string", comment = "Promotion code" },
        { name = "contact_info_usage", type = "string", comment = "Contact info master or non-master" },
        { name = "payment_method", type = "string", comment = "Payment method" },
        { name = "credit_for_companies", type = "string", comment = "DriveNow credit for companies YES or NO" },
        { name = "activation_date", type = "string", comment = "Activation date" },
        { name = "num_employees", type = "double", comment = "Number of connected emplpoyees" },
        { name = "num_employees_promotion", type = "double", comment = "Number of connected emplpoyees with corporate account promotion code" },
        { name = "pmnt_instr_exp_date", type = "string", comment = "The earliest expiration date of all existed payments instruments" }
    ]
}