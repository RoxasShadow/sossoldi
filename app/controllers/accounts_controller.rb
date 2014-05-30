class AccountsController < ApplicationController
  before_action :authenticate_user
  before_action :set_user
  before_action :set_accounts

  def index
    if params[:month].present?
      @month    = params[:month]
      @accounts = @accounts.with_items_bought_in @month
    else
      @month = :this_month
    end
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
