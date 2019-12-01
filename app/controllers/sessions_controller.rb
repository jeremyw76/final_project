class SessionsController < ApplicationController
  respond_to :json

  def new
    session[:per_page] = 10
    session[:pages] = (Photo.count / session[:per_page].to_f).ceil

    response = {
      pagination: {
        pages: session[:pages],
        per_page: session[:per_page]
      },
      session: customer_data(current_user)
    }

    render json: response
  end

  def login
    current_user = nil

    user_name = params[:user_name]
    password = params[:password]
    response = {}

    user = User.find_by(email: user_name).try(:authenticate, password)
    response[:success] = true unless user == nil

    if response[:success] then
      self.current_user = user
      response[:session] = customer_data(user)
    end

    render json: response
  end

  def destroy
    current_user = nil
    session = nil
  end

  def addresses
    customer = Customer.where(user_id: current_user.id).first

    addresses = customer.addresses.includes :province

    render json: { addresses: addresses.as_json(include: :province) }
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

    unless user.nil? || user.cart.nil? then
      cart_data = []
      user.cart.items.each do |item|
        item_data = {
          id: item["id"],
          type: item["type"],
          quantity: item["qty"]
        }

        cart_data.push item_data
      end
    end

    output = {
      customer: customer_data,
      cart: cart_data,
      csrf_token: form_authenticity_token
    }
  end
end