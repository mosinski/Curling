class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    session[:locale] = params[:locale] if params[:locale]

    I18n.locale = session[:locale] || I18n.default_locale
  end

  helper_method :current_user

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
