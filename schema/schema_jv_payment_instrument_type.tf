module "prod_jv_payment_instrument_type" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jv_payment_instrument_type"
  stage       = var.stage

  schema_columns = [
    {
      name    = "instrument_type",
      type    = "string",
      comment = ""
    },
    {
      name    = "code",
      type    = "string",
      comment = ""
    },
    {
      name    = "class",
      type    = "string",
      comment = ""
    }
  ]
}