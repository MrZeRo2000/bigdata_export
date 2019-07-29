module "int_dn_dim_dm_rpr_invoices" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_rpr_invoices"
    stage = var.stage

    schema_columns = [
        { name = "rpr_invoice_id", type = "string", comment = "" },
        { name = "rpr_order_id", type = "double", comment = "COBSOFT.FPRA.RNR" },
        { name = "rpr_invoice_net", type = "double", comment = "COBSOFT.FPRARECH.NEO" },
        { name = "rpr_invoice_currency", type = "string", comment = "COBSOFT.FPRARECH.WAKZ" },
        { name = "rpr_invoice_date", type = "string", comment = "COBSOFT.FPRARECH.RDAT" },
        { name = "load_dt", type = "string", comment = "Repair Invoice last load date. Source : sysdate" }
    ]
}