class CartsController < ApplicationController
  protect_from_forgery with: :exception

  def update
    cookie_session_id = cookies[:session_id]
    cart = Cart.where(session_id: cookie_session_id).first_or_create(session_id: session.id)

    cart.session_id = session.id
    cart.items = params[:items]
    puts cart.items
    cart.save
  end
end
