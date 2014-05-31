module Authenticable
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_logged_in?

    class NotAuthorizedError < StandardError; end
    rescue_from NotAuthorizedError, with: :user_not_authorized
  end

  def url_after_login
    user_accounts_url current_user
  end

  def url_after_logout
    root_url
  end

  def user_logged_in?
    current_user.present?
  end

  def login_as(user)
    session[:user_id] = user.try(:id)
  end

  def authenticate_user
    raise NotAuthorizedError unless user_logged_in?
  end
  alias :authenticate_user! :authenticate_user

  def check_ownership
    redirect_to user_accounts_url(current_user) unless @user == current_user
  end

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_not_authorized
    redirect_to root_url
  end
end
