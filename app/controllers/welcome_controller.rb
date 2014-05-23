class WelcomeController < ApplicationController

  def index
    login_as User.all.first

    if user_logged_in?
      redirect_to user_accounts_url(current_user)
    else
      render :index
    end
  end
end
