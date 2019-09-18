module "prod_jvbonusm" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jvbonusm"
  stage       = var.stage

  schema_columns = [
    {
      name    = "bnum",
      type    = "double",
      comment = ""
    },
    {
      name    = "wakz",
      type    = "string",
      comment = ""
    },
    {
      name    = "bet1",
      type    = "double",
      comment = ""
    },
    {
      name    = "janz",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvpp",
      type    = "string",
      comment = ""
    },
    {
      name    = "bref",
      type    = "double",
      comment = ""
    },
    {
      name    = "bas",
      type    = "double",
      comment = ""
    }
  ]
}