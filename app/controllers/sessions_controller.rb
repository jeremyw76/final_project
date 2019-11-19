class SessionsController < Devise::SessionsController
  respond_to :json

  def respond_with(user, path)
    customer = Customer.where(user_id: user.id).first
    response_data = {
      customer: {
        name: "#{customer.first_name} #{customer.last_name}"
      },
      csrf_token: form_authenticity_token
    }
    render json: response_data
  end
end