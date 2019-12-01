class CartsController < ApplicationController
  protect_from_forgery with: :exception

  def update
    cookie_session_id = cookies[:session_id]
    cart = Cart.where(session_id: cookie_session_id).first_or_create(session_id: session.id)

    cart.session_id = session.id
    cart.items = params[:items]

    unless current_user.nil?
      puts 'Current user is not nil'
      user_carts = Cart.where(user_id: current_user.id)
      user_carts.first.destroy if user_carts.count > 1

      cart.user_id = current_user.id
      puts cart.inspect
    end

    cart.save
  end
end
