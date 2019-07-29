module "int_dn_dim_dm_rpr_orders" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_rpr_orders"
    stage = var.stage

    schema_columns = [
        { name = "rpr_order_id", type = "double", comment = "Repair Order ID. Source: COBSOFT.FPRA.RNR" },
        { name = "rpr_dm_id", type = "double", comment = "Damage Id. Source: COBSOFT.FPRA.SNR" },
        { name = "rpr_order_date", type = "string", comment = "Repair Order date. Source : SELECT UDA FROM COBSOFT.FPRA@REPPRD.SIXT.DE" },
        { name = "rpr_order_type_id", type = "double", comment = "Type of the repair order. Source: COBSOFT.FPRA.RART. Desc: DN_DIM_DM_RPR_TYPES" },
        { name = "rpr_order_recipient_id", type = "double", comment = "Repair Order recipient ID (creditor). Source : COBSOFT.FPRA.KRNR" },
        { name = "rpr_order_mileage", type = "double", comment = "Mileage at repair [in km]. Source : COBSOFT.FPRA.AKTK" },
        { name = "rpr_order_update_date", type = "string", comment = "Repair Order last date update. Source : COBSOFT.FPRA.AEDA" },
        { name = "load_dt", type = "string", comment = "Last load date. Source : sysdate" },
        { name = "rpr_vehicle_id", type = "double", comment = "Vehicle ID" }
    ]
}