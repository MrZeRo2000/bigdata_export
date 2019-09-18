module "prod_jv_reloc_data" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jv_reloc_data"
  stage       = var.stage

  schema_columns = [
    {
      name    = "record_id",
      type    = "double",
      comment = ""
    },
    {
      name    = "insert_date",
      type    = "string",
      comment = ""
    },
    {
      name    = "reservation_id",
      type    = "double",
      comment = ""
    },
    {
      name    = "int",
      type    = "double",
      comment = ""
    },
    {
      name    = "pidn",
      type    = "double",
      comment = ""
    },
    {
      name    = "lpid",
      type    = "string",
      comment = ""
    },
    {
      name    = "fgst",
      type    = "string",
      comment = ""
    },
    {
      name    = "business_car_status",
      type    = "string",
      comment = ""
    },
    {
      name    = "activity_type",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvbt",
      type    = "string",
      comment = ""
    },
    {
      name    = "start_fleet_id",
      type    = "string",
      comment = ""
    },
    {
      name    = "start_city_id",
      type    = "double",
      comment = ""
    },
    {
      name    = "start_date",
      type    = "string",
      comment = ""
    },
    {
      name    = "start_position_lat",
      type    = "double",
      comment = ""
    },
    {
      name    = "start_position_lon",
      type    = "double",
      comment = ""
    },
    {
      name    = "start_address",
      type    = "string",
      comment = ""
    },
    {
      name    = "end_fleet_id",
      type    = "string",
      comment = ""
    },
    {
      name    = "end_city_id",
      type    = "double",
      comment = ""
    },
    {
      name    = "end_position_lat",
      type    = "double",
      comment = ""
    },
    {
      name    = "end_position_lon",
      type    = "double",
      comment = ""
    },
    {
      name    = "end_address",
      type    = "string",
      comment = ""
    },
    {
      name    = "end_date",
      type    = "string",
      comment = ""
    },
    {
      name    = "curr_tech_car_status",
      type    = "string",
      comment = ""
    },
    {
      name    = "next_tech_car_status",
      type    = "string",
      comment = ""
    }
  ]
}