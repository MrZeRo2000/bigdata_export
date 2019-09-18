module "prod_jvraddon" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jvraddon"
  stage       = var.stage

  schema_columns = [
    {
      name    = "jvid",
      type    = "double",
      comment = ""
    },
    {
      name    = "prc",
      type    = "string",
      comment = ""
    },
    {
      name    = "anz",
      type    = "double",
      comment = ""
    },
    {
      name    = "pgid",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvss",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvpe",
      type    = "string",
      comment = ""
    },
    {
      name    = "taco",
      type    = "string",
      comment = ""
    }
  ]
}