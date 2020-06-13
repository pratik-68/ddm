# Rails.configuration.stripe = {
#   publishable_key: Rails.configuration.stripe_publishable_key,
#   secret_key: Rails.configuration.stripe_secret_key
# }

Stripe.api_key = Rails.configuration.stripe_secret_key
