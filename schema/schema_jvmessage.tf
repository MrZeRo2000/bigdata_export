module "prod_jvmessage" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jvmessage"
  stage       = var.stage

  schema_columns = [
    {
      name    = "bnum",
      type    = "double",
      comment = ""
    },
    {
      name    = "cit",
      type    = "double",
      comment = ""
    },
    {
      name    = "int",
      type    = "double",
      comment = ""
    },
    {
      name    = "pidn",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvmt",
      type    = "string",
      comment = ""
    },
    {
      name    = "jort",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvbc",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvms",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvoi",
      type    = "double",
      comment = ""
    },
    {
      name    = "cdat",
      type    = "string",
      comment = ""
    },
    {
      name    = "cuhr",
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
      name    = "jvmc",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvid",
      type    = "double",
      comment = ""
    },
    {
      name    = "bed",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvmd",
      type    = "string",
      comment = "message topic value of node in topic tree"
    },
    {
      name    = "epid",
      type    = "double",
      comment = ""
    },
    {
      name    = "parent_topic",
      type    = "string",
      comment = "message parent topic value of parent node in topic tree"
    }
  ]
}