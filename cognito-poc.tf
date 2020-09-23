 resource "aws_cognito_user_pool" "yourpoll-poc" {

  # This is choosen when creating a user pool in the console
  name = "yourpoll-poc"
  # ATTRIBUTES
 
  admin_create_user_config {
  allow_admin_create_user_only = "false"
  }
 
  username_configuration {
      case_sensitive = false
  }

  schema {
    attribute_data_type = "String"
    mutable             = false
    name                = "email"
    required            = true
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  # POLICY
  password_policy {
    minimum_length    = "6"
    require_lowercase = false
    require_numbers   = false
    require_symbols   = false
    require_uppercase = false
    temporary_password_validity_days = "7"
  }

  # MFA & VERIFICATIONS
  mfa_configuration        = "OFF"
  auto_verified_attributes = ["email"]

  # MESSAGE CUSTOMIZATIONS
  verification_message_template {
    default_email_option  = "CONFIRM_WITH_CODE"
    email_message = "Your verification code is {####}"
    email_subject = "Your verification code"
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
    reply_to_email_address = "seu@email.com"
  }

  # TAGS
  tags = {
    project = "No Meat May"
  }
}

resource "aws_cognito_user_pool_client" "yourpoll-poc" {
  name = "yourpoll-poc"

  user_pool_id = aws_cognito_user_pool.yourpoll-poc.id

  generate_secret     = false
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
}
