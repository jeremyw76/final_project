Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.dig(:DEVELOPMENT_STRIPE_PUBLIC_KEY),
  secret_key: Rails.application.credentials.dig(:DEVELOPMENT_STRIPE_SECRET_KEY),
  ngrok_base_url: 'http://d2bfb0f4.ngrok.io'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]