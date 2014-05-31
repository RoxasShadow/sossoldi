class WelcomeController < ApplicationController

  def index
    if user_logged_in?
      redirect_to url_after_login
    else
      render :index
    end
  end
end
