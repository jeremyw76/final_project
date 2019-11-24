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
      success_url: 'http://3a76dbcb.ngrok.io/payment_success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'http://3a76dbcb.ngrok.io/payment_error?session_id={CHECKOUT_SESSION_ID}'
    )

    render json: {sessionId: session.id}
  end
end
