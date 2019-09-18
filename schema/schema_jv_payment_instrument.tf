module "prod_jv_payment_instrument" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jv_payment_instrument"
  stage       = var.stage

  schema_columns = [
    {
      name    = "instrument_id",
      type    = "string",
      comment = "UUID of the payment instrument"
    },
    {
      name    = "instrument_type",
      type    = "string",
      comment = "Type of the payment instrument VISA etc "
    },
    {
      name    = "status",
      type    = "string",
      comment = "Usage status non used only X now "
    },
    {
      name    = "insert_date",
      type    = "string",
      comment = "Payment instrument insert date"
    }
  ]
}