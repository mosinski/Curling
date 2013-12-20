class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  protect_from_forgery

  before_filter :set_locale
  before_filter :check_uri

  def set_locale
    session[:locale] = params[:locale] if params[:locale]

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  def check_uri
    if /^www/.match(request.host)
      redirect_to request..protocol + request.host_with_port[4..-1] + request.request_uri
    end
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
