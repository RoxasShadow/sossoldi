class AccountsController < ApplicationController
  before_action :authenticate_user
  before_action :set_user
  before_action :set_accounts

  def index
  end

  def create
    @accounts.create account_params

    redirect_to user_accounts_url(@user)
  end

  def destroy
    redirect_to user_accounts_url(@user)
  end

private

  def account_params
    params.required(:account).permit(:name, :money, :currency)
  end

  def set_user
    @user = User.find params[:user_id]
  end

  def set_accounts
    @accounts = @user.accounts
  end
end
