module "int_dn_fact_mnthl_clsr_vhcls" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_mnthl_clsr_vhcls"
    stage = var.stage

    schema_columns = [
        { name = "day_id", type = "string", comment = "" },
        { name = "vehicle_no", type = "double", comment = "" },
        { name = "chassis_no", type = "string", comment = "" },
        { name = "registration_no", type = "string", comment = "" },
        { name = "brand", type = "string", comment = "" },
        { name = "model", type = "string", comment = "" },
        { name = "model_derivative", type = "string", comment = "" },
        { name = "fuel_type", type = "string", comment = "" },
        { name = "first_registration_date", type = "string", comment = "" },
        { name = "registration_date", type = "string", comment = "" },
        { name = "dereg_date", type = "string", comment = "" },
        { name = "registration_city", type = "double", comment = "" },
        { name = "return_city", type = "string", comment = "" },
        { name = "num_act_days", type = "double", comment = "" },
        { name = "co2", type = "double", comment = "" },
        { name = "horsepower", type = "double", comment = "" },
        { name = "remaining_fuel", type = "double", comment = "" },
        { name = "sixt_model", type = "string", comment = "" },
        { name = "bmw_fuel_type", type = "string", comment = "" },
        { name = "delivery_date", type = "string", comment = "" },
        { name = "last_cost_center_id", type = "double", comment = "last cost center number to which the vehicle was assigned" },
        { name = "vehicle_id", type = "double", comment = "Unique identifier of vehicle in DN_DIM_VEHICLE_2" },
        { name = "return_vdc_date", type = "string", comment = "Return VDC Date. Source: DN_DIM_VEHICLE_2.DEREG_DATE" },
        { name = "motor_code", type = "string", comment = "Motor code, value is used for tax-computation. Source: VEHDEF.MOT" },
        { name = "engine_capacity", type = "double", comment = "Engine Displacement. Source: VEHDEF.CCM" }
    ]
}