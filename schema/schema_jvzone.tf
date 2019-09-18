module "prod_jvzone" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jvzone"
  stage       = var.stage

  schema_columns = [
    {
      name    = "zoni",
      type    = "double",
      comment = ""
    },
    {
      name    = "jfid",
      type    = "string",
      comment = ""
    },
    {
      name    = "pbez",
      type    = "string",
      comment = ""
    },
    {
      name    = "zont",
      type    = "string",
      comment = ""
    },
    {
      name    = "pidn",
      type    = "double",
      comment = ""
    },
    {
      name    = "parent_zone",
      type    = "double",
      comment = ""
    },
    {
      name    = "version_id",
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
    }
  ]
}