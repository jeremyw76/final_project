class SigninController < ApplicationController
  def login
    render json: User.all
  end
end
