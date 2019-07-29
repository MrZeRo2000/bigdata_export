module "int_dn_dim_fleet_v2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_fleet_v2"
    stage = var.stage

    schema_columns = [
        { name = "fleet_id", type = "string", comment = "Fleet Id; Source: METRO.JVFLEET.JFID" },
        { name = "city_id", type = "double", comment = "City Id; Source: METRO.JVCITY.CIT" },
        { name = "description", type = "string", comment = "Description of a public city" },
        { name = "company_no", type = "double", comment = "Company/country code; Source: METRO.JVFLEET.FIR" },
        { name = "country_iso", type = "string", comment = "Country ISO code; Source: METRO.JVFLEET.LISO" },
        { name = "language_code", type = "string", comment = "City language code; Source: METRO.JVCITY.JVLC" },
        { name = "timeszone", type = "string", comment = "Timezone of the city; Source: METRO.JVFLEET.TZON" },
        { name = "image_url", type = "string", comment = "Url of the city image used in the application; Source: METRO.JVFLEET.URL" },
        { name = "latitude", type = "double", comment = "Latitude of a city center; Source: METRO.JVCITY.LATU" },
        { name = "longtitude", type = "double", comment = "Longitude of a city center; Source: METRO.JVCITY.LOTU" },
        { name = "cost_center_desc", type = "string", comment = "Description of a costcentre" },
        { name = "cost_centre_type", type = "string", comment = "Type of a costcentre; Source: METRO.JVCITY.JCST" },
        { name = "load_date_time", type = "string", comment = "Load date" },
        { name = "public_city_id", type = "double", comment = "Public city ID. City of the P type; Source: METRO.JVCITY.CIT" }
    ]
}