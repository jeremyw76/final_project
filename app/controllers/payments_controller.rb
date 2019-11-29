class PaymentsController < ApplicationController
  protect_from_forgery with: :exception, except: :payments_processed


  def createPayment
    order = OrdersHelper::create_order(params)
    session = StripeHelper::get_stripe_session(order)

    render json: {sessionId: session.id}
  end

  def payments_processed
    order = Order.find_by_id(params[:data][:object][:id])
  end
end
