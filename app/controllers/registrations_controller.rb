class RegistrationsController < Devise::RegistrationsController
  respond_to :json, :html

  def create
    puts 'CREATE'
    respond_to do |format|
      format.html {
        raise ActionController::RoutingError.new('Not Found')
      }

      format.json {
        user = User.create(params.permit(user: [:email, :password, :password_confirmation])[:user])
        user.save ? (render json: {success: true}) :
                     (render json: {success: false, errors: user.errors})
      }
    end
  end
end