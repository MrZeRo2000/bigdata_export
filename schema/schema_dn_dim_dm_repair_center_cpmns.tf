module "int_dn_dim_dm_repair_center_cpmns" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_repair_center_cpmns"
    stage = var.stage

    schema_columns = [
        { name = "id", type = "double", comment = "Unique id for company used to join with DN_DIM_REPAIR_CENTERS_VIEW" },
        { name = "name", type = "string", comment = "Company name of the repair CostCenter" },
        { name = "qv_color_red", type = "double", comment = "Color code, used in QV application in chart representation" },
        { name = "qv_color_green", type = "double", comment = "Color code, used in QV application in chart representation" },
        { name = "qv_color_blue", type = "double", comment = "Color code, used in QV application in chart representation" }
    ]
}