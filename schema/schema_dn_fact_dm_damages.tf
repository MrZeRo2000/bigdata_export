module "int_dn_fact_dm_damages" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_dm_damages"
    stage = var.stage

    schema_columns = [
        { name = "id", type = "double", comment = "Unique key" },
        { name = "dm_id", type = "double", comment = "Damage id. Source : v_dmdamage.snr" },
        { name = "dm_date", type = "string", comment = "Damage date. Source : trunc(v_dmbasis.sada)" },
        { name = "dm_hour", type = "double", comment = "Damage hour. Source : to_number(to_char(v_dmbasis.sada,'hh24'))" },
        { name = "dm_minute", type = "double", comment = "Damage minute. Source : to_number(to_char(v_dmbasis.sada,'mi'))" },
        { name = "dm_second", type = "double", comment = "Damage second. Source : to_number(to_char(v_dmbasis.sada,'ss'))" },
        { name = "vehicle_id", type = "double", comment = "Vehicle id. Source : dn_dim_vehicle_view.vehicle_id where dmg_date >= dn_dim_vehicle_view.valid_from and dmg_date < dn_dim_vehicle_view.valid_to" },
        { name = "customer_id", type = "double", comment = "Customer id. Source : dn_dim_customer_view.customer_id where dmg_date >= dn_dim_customer_view.valid_from and dmg_date < dn_dim_customer_view.valid_to" },
        { name = "city_id", type = "double", comment = "City id. Source : dn_dim_fleet_view.city_id where dn_dim_fleet_view.city_id = dn_dim_vehicle_view.city_id" },
        { name = "booking_id", type = "double", comment = "Rental contract id. Source v_dmdamage.mvnr" },
        { name = "dm_object_id", type = "double", comment = "Damaged object. Source : dn_dim_dm_objects.dm_object_id" },
        { name = "dm_side_id", type = "double", comment = "Damaged side. Source : dn_dim_dm_sides.dm_side_id" },
        { name = "dm_type_id", type = "double", comment = "Damage type. Source : dn_dim_dm_types.dm_type_id" },
        { name = "dm_strength_id", type = "double", comment = "Damage strength. Source : dn_dim_dm_strength.dm_strength_id" },
        { name = "dm_is_repaired", type = "double", comment = "Flag is damage repaired ( 0 = No; 1 = Yes ). Source : verepdm.nvl(MAX(reps) KEEP (DENSE_RANK LAST ORDER BY rnr),'N')" },
        { name = "dm_is_closed", type = "double", comment = "Flag is damage closed( 0 = No; 1 = Yes ). Source : v_dmvparm.vgrp = 'AG' where vcid = v_dmhist.vcid and vcid = v_dmvcid.vcid and v_dmhist.lkz = 'N' order by v_dmhist.ndat, v_dmhist.nuhr, v_dmvcid.vcod having rownum = 1 " },
        { name = "dm_is_deleted", type = "double", comment = "Flag is damage deleted ( 0 = No; 1 = Yes ). Source : v_dmhist.lkz" },
        { name = "dm_negligence_id", type = "double", comment = "Responsible for negligence ( 0 = Unknown; 1 = Third party; 2 = Personal). Source (not final) : case when v_dmbasis.uart between 200 and 299 then 'Third party' else 'Personal' end" },
        { name = "load_dt", type = "string", comment = "" }
    ]
}