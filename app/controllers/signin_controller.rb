class SigninController < ApplicationController
  def login
    some_thing = { csrf_token: '12345', user_name: 'buddy' }
    render json: some_thing
  end
end
