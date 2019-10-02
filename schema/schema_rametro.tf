module "prod_rametro" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "rametro"
  stage       = var.stage

  schema_columns = [
    {
      name    = "mvnr",
      type    = "double",
      comment = ""
    },
    {
      name    = "hser",
      type    = "double",
      comment = ""
    },
    {
      name    = "lato",
      type    = "double",
      comment = ""
    },
    {
      name    = "loto",
      type    = "double",
      comment = ""
    },
    {
      name    = "joro",
      type    = "string",
      comment = ""
    },
    {
      name    = "lati",
      type    = "double",
      comment = ""
    },
    {
      name    = "loti",
      type    = "double",
      comment = ""
    },
    {
      name    = "jori",
      type    = "string",
      comment = ""
    },
    {
      name    = "minf",
      type    = "double",
      comment = ""
    },
    {
      name    = "minh",
      type    = "double",
      comment = ""
    },
    {
      name    = "tbe",
      type    = "double",
      comment = ""
    },
    {
      name    = "ten",
      type    = "double",
      comment = ""
    },
    {
      name    = "clns",
      type    = "string",
      comment = ""
    },
    {
      name    = "avgc",
      type    = "double",
      comment = ""
    },
    {
      name    = "akko",
      type    = "double",
      comment = ""
    },
    {
      name    = "akki",
      type    = "double",
      comment = ""
    },
    {
      name    = "jprk",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvpf",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvpd",
      type    = "double",
      comment = ""
    },
    {
      name    = "pidn",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvrt",
      type    = "string",
      comment = ""
    },
    {
      name    = "bekz",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvis",
      type    = "double",
      comment = ""
    },
    {
      name    = "jvpt",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvkm",
      type    = "double",
      comment = ""
    },
    {
      name    = "minp",
      type    = "double",
      comment = ""
    },
    {
      name    = "gpri",
      type    = "string",
      comment = ""
    },
    {
      name    = "jvap",
      type    = "double",
      comment = ""
    },
    {
      name    = "juci",
      type    = "double",
      comment = ""
    },
    {
      name    = "jrci",
      type    = "double",
      comment = ""
    },
    {
      name    = "booking_id",
      type    = "double",
      comment = "Reference to booking Is set if the operation is made via new rating engine"
    },
    {
      name    = "operation_id",
      type    = "double",
      comment = ""
    },
    {
      name    = "external_system_code",
      type    = "string",
      comment = ""
    },
    {
      name    = "insert_date",
      type    = "string",
      comment = ""
    },
    {
      name    = "external_operation_id",
      type    = "double",
      comment = ""
    },
    {
      name    = "amount",
      type    = "double",
      comment = ""
    },
    {
      name    = "currency",
      type    = "string",
      comment = ""
    },
    {
      name    = "minimal_fuel_level",
      type    = "double",
      comment = "minimal fuel value during trip"
    },
    {
      name    = "parent_id",
      type    = "double",
      comment = "parent owner in case of corp account account id"
    }
  ]
}