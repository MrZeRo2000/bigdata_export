module "prod_jv_product_attribute" {
  source     = "../../../modules/schema"
  account_id = var.account_id

  domain_name = var.domain_name
  schema_name = "jv_product_attribute"
  stage       = var.stage

  schema_columns = [
    {
      name    = "product_id",
      type    = "double",
      comment = "Reference to product ID"
    },
    {
      name    = "attr_name",
      type    = "string",
      comment = "Attribute name"
    },
    {
      name    = "attr_value",
      type    = "string",
      comment = "Attribute value"
    },
    {
      name    = "alias_cd",
      type    = "string",
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