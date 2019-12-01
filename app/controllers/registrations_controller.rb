class RegistrationsController < ApplicationController
  respond_to :json, :html

  def create
    respond_to do |format|
      format.html {
        raise ActionController::RoutingError.new('Not Found')
      }

      format.json {
        user = User.new(
          email: params[:user][:email],
          password: params[:user][:password],
          password_confirmation: params[:user][:password_confirmation]
        )

        if user.save then
          customer = Customer.new(
            first_name: params[:user][:firstName],
            last_name: params[:user][:lastName],
            user_id: user.id
          )

          if customer.save then
            render json: {success: true}
          else
            render json: {success:false}
          end
        else
          render json: {success: false, errors: user.errors}
        end
      }
    end
  end
end