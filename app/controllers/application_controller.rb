class ApplicationController < ActionController::Base
  after_action :initialize_cookie_session_id
  after_action :set_csrf_token_header

  def initialize_cookie_session_id
    cookies[:session_id] ||= session.id
  end

  def set_csrf_token_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end
