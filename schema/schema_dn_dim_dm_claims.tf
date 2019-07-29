module "int_dn_dim_dm_claims" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_dm_claims"
    stage = var.stage

    schema_columns = [
        { name = "dm_id", type = "double", comment = "Damage id. Source: DMSTATFORD.SNR" },
        { name = "dm_clm_fnl_volume", type = "double", comment = "Final Claim Volume [in €]. Source: DMSTATFORD.AKTFORD_KUNDE" },
        { name = "dm_clm_fnl_date", type = "string", comment = "Final Claim Date. Source: DMSTATFORD.FORD_DATUM" },
        { name = "dm_clm_clamed", type = "double", comment = "Flag is damage clamed( 0 = No; 1 = Yes ). Rule: claimed when we invoiced this customer for this damage. logically in SQL it exists a date in DMSTATFORD.FORD_DATUM and amount in DMSTATFORD.AKTFORD_KUNDE > 0" },
        { name = "dm_clm_closed", type = "double", comment = "Flag is damage closed( 0 = No; 1 = Yes ). Rule : V_DMVPARM.VGRP = 'AG' where VCID = V_DMHIST.VCID and VCID = V_DMVCID.VCID and V_DMHIST.LKZ = 'N' order by V_DMHIST.NDAT, V_DMHIST.NUHR, V_DMVCID.VCOD having rownum = 1 " },
        { name = "dm_clm_active", type = "double", comment = "Flag is damage active( 0 = No; 1 = Yes ). Rule: in progress counts all DM_CLM_CLOSED = 0 and DM_CLM_FNL_VOLUME = 0 and DM_CLM_FNL_DATE is null" },
        { name = "dm_clm_repaired", type = "double", comment = "Flag is damage repaired( 0 = No; 1 = Yes ). Rule: repair order ID exists connected to damage ID" },
        { name = "load_dt", type = "string", comment = "Last load date. Source : sysdate" },
        { name = "dm_clm_ac_volume", type = "double", comment = "Claim volume" },
        { name = "dm_clm_ac_pmnt_volume", type = "double", comment = "Payment volume" }
    ]
}