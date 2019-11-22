class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super

    unless current_user.cart.nil?
      current_user.cart.session_id = session.id
      current_user.cart.save
    else
      cart = Cart.where(session_id: session.id).first_or_create(session_id: session.id)
      cart.user_id = current_user.id
      cart.save
    end
  end

  def show
    if cookies[:session_id] === session.id then
      response_data = customer_data(current_user)
    else
      response_data = {
        customer: nil,
        cart: [],
        csrf_token: form_authenticity_token
      }
    end

    cookies[:session_id] = session.id
    render json: response_data
  end

  def destroy
    super

    session = nil
  end

  def respond_with(user, path)
    render json: customer_data(user)
  end

  def refresh
    render json: {csrf_token: form_authenticity_token}
  end

  def customer_data(user)
    customer = Customer.where(user_id: user.id).first unless user.nil?
    customer = nil if user.nil?
    customer_data = customer.nil? ? nil : {
      name: "#{customer.first_name} #{customer.last_name}"
    }

    cart_data = []

    # unless user.nil? || user.cart.nil? then
    #   puts 'now'
    #   puts JSON.parse(user.cart.items)[0]
    #   puts "hi"
    #   JSON.parse(user.cart.items).each do |item|
    #     puts item.type
    #     item_data = {
    #       id: item["id"],
    #       type: item["type"]
    #     }
    #     cart_data.push item_data
    #   end
    # end

    output = {
      customer: customer_data,
      cart: cart_data,
      csrf_token: form_authenticity_token
    }

    puts output
    return output
  end
end