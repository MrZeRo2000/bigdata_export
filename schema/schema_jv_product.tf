module "prod_jv_product" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jv_product"
  stage       = var.stage

  schema_columns = [
    {
      name    = "product_id",
      type    = "double",
      comment = "Unique product ID Code PRC "
    },
    {
      name    = "product_code",
      type    = "string",
      comment = "Speaking code of the product Products will be found basing on code withing tenants "
    },
    {
      name    = "jvti",
      type    = "double",
      comment = "Business unit ID"
    },
    {
      name    = "parent_id",
      type    = "double",
      comment = "Parent product Will be used to identify sub products"
    },
    {
      name    = "partner_id",
      type    = "double",
      comment = "reference to the parter that is offering this product"
    },
    {
      name    = "product_name",
      type    = "string",
      comment = "Product name"
    },
    {
      name    = "priority",
      type    = "double",
      comment = "Priority for the identification sequence"
    },
    {
      name    = "pricing_derivate",
      type    = "string",
      comment = "Type of the pricing storage matrix NWR tjhat defines how the price dimentions are stored"
    },
    {
      name    = "product_type",
      type    = "string",
      comment = "Tape of the product that defines which application class is responsible for the product functionality"
    },
    {
      name    = "seq_number",
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
      name    = "fir",
      type    = "double",
      comment = ""
    },
    {
      name    = "tax_model_code",
      type    = "string",
      comment = "Code of the tax model for example DEFAULT or TAXFREE"
    },
    {
      name    = "prod_spec_code",
      type    = "string",
      comment = "Code of the product specification Is common for similar products of different tenants"
    },
    {
      name    = "price",
      type    = "double",
      comment = "Reference price to be presented for standard conditions"
    },
    {
      name    = "currency",
      type    = "string",
      comment = "Currency to present price ISO code "
    },
    {
      name    = "price_brutto",
      type    = "double",
      comment = " TEMPORARY WA Configured brutto price by default tax model "
    },
    {
      name    = "price_list",
      type    = "string",
      comment = "Sixt price list prl "
    },
    {
      name    = "agreement_type",
      type    = "string",
      comment = "Sixt type of agreement jvrt "
    },
    {
      name    = "stop_selling_date",
      type    = "string",
      comment = "Date when selling of the product will be stopped"
    }
  ]
}