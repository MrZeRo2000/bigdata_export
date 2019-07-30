module "int_dn_dim_vehicle_2" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_dim_vehicle_2"
    stage = var.stage

    schema_columns = [
        { name = "vehicle_no", type = "double", comment = "Vehicle number used in METRO ( core ) system; Source: METRO.JVCARS.INT" },
        { name = "fleet_id", type = "string", comment = "Fleet Id; Source: METRO.JVFLEET.JFID" },
        { name = "city_id", type = "double", comment = "City Id; Source: METRO.JVCITY.CIT" },
        { name = "ampel", type = "string", comment = "Vehicle status (F)ree, s(O)ld, (D)rive, (P)arked; Source: METRO.JVCARS.AMPL" },
        { name = "location_latitude", type = "double", comment = "Latitude of a vehicle; Source: METRO.JVCARS.LATU" },
        { name = "location_longtitude", type = "double", comment = "Longitude of a vehicle; Source: METRO.JVCARS.LOTU" },
        { name = "location", type = "string", comment = "Location address; Source: METRO.JVCARS.JORT" },
        { name = "picture_no", type = "double", comment = "Deprecated; Source: METRO.JVCARS.BILD" },
        { name = "last_seen", type = "double", comment = "BMW timestamp of the last car update; Source: METRO.JVCARS.VTST" },
        { name = "service_block_type", type = "string", comment = "Service block type on a vehicle; Source: METRO.JVCARS.JVBT" },
        { name = "service_block_comment", type = "string", comment = "Service block comments; Source: METRO.JVCARS" },
        { name = "clean_state", type = "string", comment = "Vehicle cleanliness; Source: METRO.JVCARS" },
        { name = "chassis_no", type = "string", comment = "Chassis number; Source: METRO.JVCARS.FGST" },
        { name = "lacquer", type = "string", comment = "Lacquer of a vehicle; Source: METRO.JVCARS.LACK" },
        { name = "manufacturer_code", type = "string", comment = "Manufacturer Code (Abbreviation); Source: METRO.JVCARS.MANC" },
        { name = "model", type = "string", comment = "Model designation (GL, CL, GTI); Source: METRO.JVCARS.MODL" },
        { name = "model_derivative", type = "string", comment = "Model Derivative e.g. CL, TDI, GTI; Source: METRO.JVCARS.DERV" },
        { name = "fuel_level", type = "double", comment = "Fuel content of a vehicle; Source: METRO.JVCARS.TANK" },
        { name = "registration_no", type = "string", comment = "Registration number; Source: METRO.JVCARS.AMT" },
        { name = "city_cost_center", type = "double", comment = "City number, cost centre; Source: METRO.JVCARS.CIT" },
        { name = "parking_vay_no", type = "string", comment = "Metropolis parkingBayNumber. Deprecated; Source: METRO.JVCARS.JPRK" },
        { name = "shifting_type", type = "string", comment = "Manuel (Y/N); Source: METRO.JVCARS.MAN" },
        { name = "bmw_model", type = "string", comment = "Metropolis BMW Model; Source: METRO.JVCARS.CDMD" },
        { name = "bmw_color", type = "string", comment = "Metropolis BMW Color; Source: METRO.JVCARS.CDCL" },
        { name = "bmw_fuel_type", type = "string", comment = "Metropolis BMW Fuel type; Source: METRO.JVCARS.CDFT" },
        { name = "latest_damage_no", type = "double", comment = "Damage number (latest); Source: METRO.JVCARS.SNR" },
        { name = "vehicle_group", type = "string", comment = "Vehicle group; Source: METRO.JVCARS.GRP" },
        { name = "personal_no", type = "string", comment = "Metropolis : personal name of the vehicle; Source: METRO.JVCARS.JVPN" },
        { name = "service_block", type = "string", comment = "Metropolis Service Block; Source: METRO.JVCARS.JVSB" },
        { name = "configuration_name", type = "string", comment = "Metropolis Configuration name; Source: METRO.JVCARS.JVCN" },
        { name = "in_car_device_latitude", type = "double", comment = "Latitude of the in-car device; Source: METRO.JVCARS.LATD" },
        { name = "in_car_device_longtitude", type = "double", comment = "Longitude of the in-car device; Source: METRO.JVCARS.LOTD" },
        { name = "in_car_device_location", type = "string", comment = "Address of the in-car device; Source: METRO.JVCARS.ADRD" },
        { name = "parking_garage_id", type = "double", comment = "ID of the parking garage; Source: METRO.JVCARS.PGID" },
        { name = "charging_time", type = "double", comment = "Vehicle time stamp (charging event); Source: METRO.JVCARS.VTSC" },
        { name = "in_car_device_software_ver", type = "string", comment = "Version of the in-car Software; Source: METRO.JVCARS.JVSV" },
        { name = "driven_distance", type = "double", comment = "Metropolis Vehicle Distance; Source: METRO.JVCARS.JVVD" },
        { name = "reverse_driven_distance", type = "double", comment = "Metropolis Reverse Vehicle Distance; Source: METRO.JVCARS.JVRD" },
        { name = "alt_location_latitude", type = "double", comment = "latitude of alternative loaction; Source: METRO.JVCARS.LATA" },
        { name = "alt_location_longtitude", type = "double", comment = "longitude of alternative location; Source: METRO.JVCARS.LOTA" },
        { name = "phase", type = "string", comment = "Metropolis Vehicle Phase; Source: METRO.JVCARS.JVVP" },
        { name = "origin", type = "string", comment = "Metropolis Vehicle Origin; Source: METRO.JVCARS.JVVO" },
        { name = "class", type = "string", comment = "Not used; Source: METRO.JVCARS.FZKL" },
        { name = "connection_vendor", type = "string", comment = "Metropolis Car Conenction Vendor; Source: METRO.JVCARS.JVCV" },
        { name = "definition_reference", type = "double", comment = "Car definition reference code; Source: METRO.JVCARS.CDEF" },
        { name = "expiration_date", type = "string", comment = "Expiration date. Deprecated; Source: METRO.JVCARS.REG_DATE" },
        { name = "seats", type = "double", comment = "Number of seats; Source: METRO.JVCARMODEL.SEAT" },
        { name = "vehicle_id", type = "double", comment = "Vehicle ID" },
        { name = "valid_from", type = "string", comment = "Validity start" },
        { name = "valid_to", type = "string", comment = "Validity end" },
        { name = "active_version", type = "double", comment = "Flag for active/last version (1)" },
        { name = "registration_date", type = "string", comment = "Registration date; Source: SIXT.WHVEH.ZULD" },
        { name = "delivery_date", type = "string", comment = "Delivery date; Source: SIXT.WHVEH.ANL" },
        { name = "internal_dereg_date", type = "string", comment = "Registration date; Source: SIXT.WHVEH.ZULD" },
        { name = "dereg_date", type = "string", comment = "Car registration cancellation date; Source: SIXT.WHVEH.ABM" },
        { name = "exact_dereg_date", type = "string", comment = "Exact deregistration date; Source: SIXT.WHVWH.TABD" },
        { name = "final_date_of_sale", type = "string", comment = "Date of the final sale of a vehicle; Source: SIXT.WHVWH.DATV" },
        { name = "horsepower", type = "double", comment = "Horsepower of a vehicle; Source: SIXT.VEHDEF.PS" },
        { name = "co2", type = "double", comment = "ECE CO2; Source: SIXT.VEHADM.CO2" },
        { name = "change_date_time", type = "string", comment = "Calculation date; Source: METRO.JVCARS" },
        { name = "tank_capacity", type = "double", comment = "Tank capacity; Source: METRO.JVCARMODEL.CAPA" },
        { name = "registration_status", type = "double", comment = "Registration status; Source: SIXT.WHVEH.ZEST" },
        { name = "type_number", type = "double", comment = "" },
        { name = "max_mileage", type = "double", comment = "" },
        { name = "max_duration", type = "double", comment = "Aspired holding time of a vehicle in days; Source: SIXT.WHVEH.LAUF" },
        { name = "first_registration_date", type = "string", comment = "First Registration date; Source: SIXT.WHVEH.EZUL" },
        { name = "net_status", type = "double", comment = "Net status; Source: SIXT.WHVEH.NEST" },
        { name = "list_price", type = "double", comment = "List price net; Source: SIXT.WHVEH.LIPR" },
        { name = "current_mileage", type = "double", comment = "Current mileage; Source: SIXT.WHVEH.AKTK" },
        { name = "insurance_number", type = "string", comment = "Insurance number; Source: SIXT.WHVEH.VSNR" },
        { name = "ind_vehicle_date", type = "string", comment = "Individual vehicle date. Deprecated; Source: SIXT.WHVEH.ILZD" },
        { name = "bb_contract_number", type = "string", comment = "Buy Back Contract Number. Deprecated; Source: SIXT.VEHBBCN.BBCN" },
        { name = "fuel_capacity", type = "double", comment = "Fuel content of a vehicle; Source: SIXT.VEHTYP.FTYP" },
        { name = "defleet_date", type = "string", comment = "Defleet date (ILZD + LAUF); Source: SIXT.WHVEH" },
        { name = "tire_config", type = "string", comment = "Tire configuration (NonRunflat, Runflat); Source: METRO.JVCARATTR" },
        { name = "rim_type", type = "string", comment = "Rim type (Aluminium, Steel); Source: METRO.JVCARATTR" },
        { name = "tire_type", type = "string", comment = "Tire type (Winter, Summer); Source: METRO.JVCARATTR" },
        { name = "reader_version", type = "string", comment = "Card reader version; Source: METRO.JVCARATTR" },
        { name = "sixt_lacquer", type = "string", comment = "Lacquer of a vehicle; Source: SIXT.VEHICLE.LACK" },
        { name = "transmission_type", type = "string", comment = "Transmission type; Source: METRO.JVCARS.MAN" },
        { name = "fuel_type", type = "string", comment = "Fuel type; Source: METRO.JVCARS" },
        { name = "is_test_car", type = "string", comment = "Flag used for a test cars; Source: METRO.JVCARS" },
        { name = "supplier_no", type = "string", comment = "Supplier No; Source: SIXT.WHVEH.HDNR" },
        { name = "supplier_text", type = "string", comment = "Supplier Text; Source: SIXT.PAADR.NAM1" },
        { name = "leasing_rate", type = "double", comment = "Leasing rate; Source: SIXT.VEHLEASE" },
        { name = "first_rent_date_sixt", type = "string", comment = "Date of the first rental; Source: SIXT.VEHLIFE" }
    ]
}