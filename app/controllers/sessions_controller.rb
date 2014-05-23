class SessionsController < ApplicationController

  def create
    user = find_user_based_on_authentication_type

    if user_authenticated? user
      login_as(user) && redirect_to(url_after_login)
    else
      redirect_to root_url
    end
  end

  def destroy
    session.delete :user_id
    redirect_to url_after_logout
  end

private

  def find_user_based_on_authentication_type
    if omniauth_request.present?
      User.from_omniauth(omniauth_request)
    else
      User.find email: params[:session][:email]
    end
  end

  def user_authenticated?(user)
    if request.env['omniauth.auth'].present?
      user.present?
    else
      user.present? && user.authenticate(params[:session][:password])
    end
  end

  def omniauth_request
    request.env['omniauth.auth']
  end
end