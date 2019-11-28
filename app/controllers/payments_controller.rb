class PaymentsController < ApplicationController
  protect_from_forgery with: :exception, except: :payments_processed


  def createPayment
    session = StripeHelper::get_stripe_session(params)

    render json: {sessionId: session.id}
  end

  def payments_processed
    puts params
  end
end
