module "int_jv_payment_instrument_attr" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jv_payment_instrument_attr"
  stage       = var.stage

  schema_columns = [
    {
      name    = "instrument_id",
      type    = "string",
      comment = ""
    },
    {
      name    = "name",
      type    = "string",
      comment = ""
    },
    {
      name    = "value",
      type    = "string",
      comment = ""
    },
    {
      name    = "update_date",
      type    = "string",
      comment = ""
    }
  ]
}