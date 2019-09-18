module "prod_jvbonus" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jvbonus"
  stage       = var.stage

  schema_columns = [
    {
      name    = "bnum",
      type    = "double",
      comment = ""
    },
    {
      name    = "pidn",
      type    = "double",
      comment = ""
    },
    {
      name    = "role",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvis",
      type    = "double",
      comment = ""
    },
    {
      name    = "jgru",
      type    = "string",
      comment = ""
    },
    {
      name    = "jein",
      type    = "string",
      comment = ""
    },
    {
      name    = "janz",
      type    = "double",
      comment = ""
    },
    {
      name    = "ndat",
      type    = "string",
      comment = ""
    },
    {
      name    = "nuhr",
      type    = "double",
      comment = ""
    },
    {
      name    = "bdat",
      type    = "string",
      comment = ""
    },
    {
      name    = "buhr",
      type    = "double",
      comment = ""
    },
    {
      name    = "bekz",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvit",
      type    = "double",
      comment = ""
    },
    {
      name    = "bed",
      type    = "double",
      comment = ""
    },
    {
      name    = "gpri",
      type    = "string",
      comment = ""
    },
    {
      name    = "vdat",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvpp",
      type    = "string",
      comment = ""
    },
    {
      name    = "konr",
      type    = "double",
      comment = ""
    },
    {
      name    = "saldo",
      type    = "double",
      comment = ""
    },
    {
      name    = "description",
      type    = "string",
      comment = ""
    },
    {
      name    = "external_system_id",
      type    = "string",
      comment = "Internal idenfier to link bonus entries to business operations "
    },
    {
      name    = "external_system_type",
      type    = "string",
      comment = "Name of internal source to link bonus entries to business operations "
    }
  ]
}