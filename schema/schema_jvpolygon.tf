module "prod_jvpolygon" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jvpolygon"
  stage       = var.stage

  schema_columns = [
    {
      name    = "jpli",
      type    = "double",
      comment = ""
    },
    {
      name    = "zoni",
      type    = "double",
      comment = ""
    },
    {
      name    = "bed",
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
      name    = "parent_jpli",
      type    = "double",
      comment = ""
    }
  ]
}