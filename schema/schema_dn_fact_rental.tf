module "int_dn_fact_rental" {
    source = "../../../modules/schema"
    account_id = var.account_id

    domain_name = var.domain_name
    schema_name = "dn_fact_rental"
    stage = var.stage

    schema_columns = [
        { name = "load_date_time", type = "string", comment = "Insert date; Source: SYSDATE" },
        { name = "rental_contract_id", type = "double", comment = "Booking ID; Source: METRO.JVRES.MVNR" },
        { name = "reservation_status", type = "double", comment = "Reservation status [0;70]; Source: METRO.JVRES.JVST" },
        { name = "date_last_update", type = "string", comment = "Last date update; Source: METRO.JVRES.NDAT" },
        { name = "date_reservation", type = "string", comment = "Reservation date; Source: METRO.JVRES.UDA" },
        { name = "date_drive", type = "string", comment = "Start drive date; Source: METRO.JVRES.RDA" },
        { name = "date_return", type = "string", comment = "Return date; Source: METRO.JVRES.ODA" },
        { name = "vehicle_no", type = "double", comment = "Vehicle number used in METRO ( core ) system; Source: METRO.CARS.INT" },
        { name = "vehicle_type", type = "string", comment = "Vehicle type; Source: SIXT.WHVEH.TNAM" },
        { name = "customer_no", type = "double", comment = "Customer ID used in METRO ( core ) system; Source: METRO.PAMETRO.PIDN" },
        { name = "customer_card", type = "string", comment = "Customer Id card; Source: METRO.PAMETLAP.LPID" },
        { name = "city", type = "double", comment = "City Id when rental was started; Source: METRO.JVCARS.CIT" },
        { name = "start_zip", type = "string", comment = "Start address; Source: METRO.RAMETRO" },
        { name = "start_address", type = "string", comment = "Start address; Source: METRO.RAMETRO" },
        { name = "start_lat", type = "double", comment = "Start latitude; Source: METRO.RAMETRO.LATO" },
        { name = "start_lot", type = "double", comment = "Start longitude; Source: METRO.RAMETRO.LOTO" },
        { name = "start_garage_id", type = "double", comment = "Garage Id were journey was started; Source: METRO.RAMETRO.OPG" },
        { name = "end_zip", type = "string", comment = "End address; Source: METRO.RAMETRO" },
        { name = "end_address", type = "string", comment = "End address; Source: METRO.RAMETRO" },
        { name = "end_lat", type = "double", comment = "End latitude; Source: METRO.RAMETRO.LATI" },
        { name = "end_lot", type = "double", comment = "End longitude; Source: METRO.RAMETRO.LOTI" },
        { name = "end_garage_id", type = "double", comment = "Garage Id were journey was finished; Source: METRO.RAMETRO.IPG" },
        { name = "start_fuel", type = "double", comment = "Tank start volume in litres; Source: METRO.RAMETRO.TBE" },
        { name = "end_fuel", type = "double", comment = "Tank end volume in litres; Source: METRO.RAMETRO.TEN" },
        { name = "clean_state", type = "string", comment = "Clean state; Source: METRO.JVRES.CLNS" },
        { name = "price_list", type = "string", comment = "Price list; Source: SIXT.RARENT.PRL" },
        { name = "reservation_type", type = "string", comment = "Type of a reservation: (P)rivate, (B)usiness; Source: METRO.RAMETRO.GPRI" },
        { name = "service_order", type = "string", comment = "Service Order; Source: DN_FACT_SERVICE_ORDERS_USG_V2" },
        { name = "vehicle_id", type = "double", comment = "Vehicle ID; Source: METRO.JVRES.INT" },
        { name = "customer_id", type = "double", comment = "Customer ID; Source: DRIVENOW_BI.DN_DIM_CUSTOMER_V2.CUSTOMER_ID" },
        { name = "duration_reservation", type = "double", comment = "Reservation duration in minutes (free+paid); Source: calculated" },
        { name = "duration_driving", type = "double", comment = "Driving duration in minutes; Source: calculated" },
        { name = "total_duration", type = "double", comment = "Total duration; Source: calculated" },
        { name = "duration_parking", type = "double", comment = "Parking duration in minutes; Source: calculated" },
        { name = "distance", type = "double", comment = "Distance of a journey in kilometers; Source: calculated" },
        { name = "low_charge_time_window", type = "double", comment = "Period validity for minimal bettery level [1-4]; Source: METRO.JV_CONFIG" },
        { name = "reservation_type_name", type = "string", comment = "Reservation type; Source: METRO.JVRES.RSTP" },
        { name = "reservation_subtype_name", type = "string", comment = "Reservation type; Source: calculated" },
        { name = "open_car_via_app", type = "string", comment = "Open car via mobile application; Source: METRO.JVRESATTR" },
        { name = "close_car_via_app", type = "string", comment = "Close car via mobile application; Source: METRO.JVRESATTR" },
        { name = "tank_start_percentage", type = "double", comment = "Tank start volume in percent; Source: METRO.JV_CARS_REFUEL" },
        { name = "tank_end_percentage", type = "double", comment = "Tank start volume in percent; Source: METRO.JV_CARS_REFUEL" },
        { name = "start_mileage", type = "double", comment = "Current kilometers level at the start of a rental; Source: METRO.RAMETRO.AKKO" },
        { name = "end_mileage", type = "double", comment = "Current kilometers level at the end of a rental; Source: METRO.RAMETRO.AKKI" },
        { name = "rental_company_name", type = "string", comment = "Rental company name; Source: SIXT.RAADR.NAM1" },
        { name = "tank_start_volume", type = "double", comment = "Tank start volume in litres; Source: METRO.JV_CARS_REFUEL" },
        { name = "tank_end_volume", type = "double", comment = "Tank end volume in litres; Source: METRO.JV_CARS_REFUEL" },
        { name = "battery_start_percentage", type = "double", comment = "Battery start percentage; Source: METRO.JV_CARS_REFUEL" },
        { name = "battery_end_percentage", type = "double", comment = "Battery end percentage; Source: METRO.JV_CARS_REFUEL" },
        { name = "media", type = "string", comment = "PIN Entry Medium -> Possible Values are APP and CAR" }
    ]
}