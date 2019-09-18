module "prod_jvres" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jvres"
  stage       = var.stage

  schema_columns = [
    {
      name    = "jvid",
      type    = "double",
      comment = ""
    },
    {
      name    = "cdid",
      type    = "string",
      comment = ""
    },
    {
      name    = "lpid",
      type    = "string",
      comment = ""
    },
    {
      name    = "resn",
      type    = "double",
      comment = ""
    },
    {
      name    = "mvnr",
      type    = "double",
      comment = ""
    },
    {
      name    = "int",
      type    = "double",
      comment = ""
    },
    {
      name    = "fgst",
      type    = "string",
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
      name    = "jort",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvst",
      type    = "double",
      comment = ""
    },
    {
      name    = "uda",
      type    = "string",
      comment = ""
    },
    {
      name    = "uti6",
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
      name    = "cres",
      type    = "string",
      comment = ""
    },
    {
      name    = "crcd",
      type    = "double",
      comment = ""
    },
    {
      name    = "blid",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvbt",
      type    = "string",
      comment = ""
    },
    {
      name    = "mbtm",
      type    = "double",
      comment = ""
    },
    {
      name    = "aco",
      type    = "string",
      comment = ""
    },
    {
      name    = "refn",
      type    = "double",
      comment = ""
    },
    {
      name    = "blof",
      type    = "string",
      comment = ""
    },
    {
      name    = "rstp",
      type    = "string",
      comment = ""
    },
    {
      name    = "oda",
      type    = "string",
      comment = ""
    },
    {
      name    = "oti6",
      type    = "double",
      comment = ""
    },
    {
      name    = "rda",
      type    = "string",
      comment = ""
    },
    {
      name    = "rti6",
      type    = "double",
      comment = ""
    },
    {
      name    = "cidn",
      type    = "double",
      comment = ""
    },
    {
      name    = "gpri",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvof",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvap",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvab",
      type    = "double",
      comment = ""
    },
    {
      name    = "clns",
      type    = "string",
      comment = ""
    },
    {
      name    = "rsst",
      type    = "string",
      comment = ""
    },
    {
      name    = "opg",
      type    = "double",
      comment = ""
    },
    {
      name    = "ipg",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvip",
      type    = "double",
      comment = ""
    },
    {
      name    = "cart_id",
      type    = "double",
      comment = ""
    },
    {
      name    = "handshake_id",
      type    = "double",
      comment = "if car reservation is on handshake agreement this id will refer to separate table"
    }
  ]
}