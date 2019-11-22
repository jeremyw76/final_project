class CheckoutController < ApplicationController
  protect_from_forgery with: :exception

  def loadCheckout
    customer = Customer.where(user_id: current_user.id).first

    addresses = customer.addresses.includes :province
    provinces = Province.all

    render json: { addresses: addresses.as_json(include: :province), provinces: provinces }
  end
end
