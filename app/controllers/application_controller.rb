class ApplicationController < ActionController::Base
  after_action :initialize_cookie_session_id

  def initialize_cookie_session_id
    cookies[:session_id] ||= session.id
  end
end
