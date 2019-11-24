class PaymentsController < ApplicationController
  protect_from_forgery with: :exception

  def createPayment
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'test product',
        description: 'grey',
        currency: 'cad',
        amount: 1500,
        quantity: 1
      }],
      success_url: "http://#{Rails.configuration.stripe[:ngrok_base_url]}/payment_success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "http://#{Rails.configuration.stripe[:ngrok_base_url]}/payment_error?session_id={CHECKOUT_SESSION_ID}"
    )

    render json: {sessionId: session.id}
  end
end
