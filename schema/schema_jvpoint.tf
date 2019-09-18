module "prod_jvpoint" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jvpoint"
  stage       = var.stage

  schema_columns = [
    {
      name    = "jpoi",
      type    = "double",
      comment = ""
    },
    {
      name    = "jpli",
      type    = "double",
      comment = ""
    },
    {
      name    = "latu",
      type    = "double",
      comment = ""
    },
    {
      name    = "lotu",
      type    = "double",
      comment = ""
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
    },
    {
      name    = "point_order",
      type    = "double",
      comment = "Unusable column Use JPOI to order"
    },
    {
      name    = "altitude",
      type    = "double",
      comment = ""
    }
  ]
}