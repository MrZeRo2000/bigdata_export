module "int_dn_fact_qa_checking_detail" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_qa_checking_detail"
    stage = var.stage

    schema_columns = [
        { name = "check_code", type = "string", comment = "Validation rule code" },
        { name = "reported_date", type = "string", comment = "Calculated BI period" },
        { name = "fleet_code", type = "string", comment = "Identifier of Fleet CODE" },
        { name = "attr_name", type = "string", comment = "Attr. name ( RENTAL_ID,PRODUCT_CODE,CHARGE_CODE.CUSTOMER_ID,VHHICLE_ID)etc." },
        { name = "insert_date", type = "string", comment = "Date when record is inserted" },
        { name = "jira_number", type = "string", comment = "JIRA number" },
        { name = "status", type = "string", comment = "Status" },
        { name = "fir", type = "double", comment = "Tenant identifier" },
        { name = "attr_value", type = "string", comment = "" }
    ]
}