class PaymentsController < ApplicationController
  protect_from_forgery with: :exception, except: :payments_processed

  def createPayment
    order = OrdersHelper::create_order(params)
    @@stripe_session = StripeHelper::get_stripe_session(order)

    render json: {sessionId: @@stripe_session.id}
  end

  def payments_processed
    order = Order.find_by_id(@@stripe_session[:client_reference_id])

    if (params['data']['object']['status'] === 'succeeded') then
      order.status = 'paid'
      order.save
    end
  end
end