module "prod_jv_product_availability" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jv_product_availability"
  stage       = var.stage

  schema_columns = [
    {
      name    = "product_id",
      type    = "double",
      comment = "Unique product ID Code PRC "
    },
    {
      name    = "jfid",
      type    = "string",
      comment = "Reference to the fleet"
    },
    {
      name    = "valid_from",
      type    = "string",
      comment = "Date and time from which the price is valid"
    },
    {
      name    = "valid_to",
      type    = "string",
      comment = "Date and time to which the price is valid"
    },
    {
      name    = "time_pattern",
      type    = "string",
      comment = "Product availability description in meta language Is emply if the product available the whole time"
    },
    {
      name    = "insert_date",
      type    = "string",
      comment = ""
    },
    {
      name    = "last_update_date",
      type    = "string",
      comment = ""
    },
    {
      name    = "last_change_person",
      type    = "string",
      comment = ""
    }
  ]
}