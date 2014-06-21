class AccountsController < ApplicationController
  before_action :authenticate_user
  before_action :set_user
  before_action :set_accounts
  before_action :check_ownership

  def index
    @month = params[:month] || :this_month

    respond_to do |format|
      format.html

      format.json { render json: @accounts, include: :items }

      format.xml { render xml: @accounts, include: :items }
    end
  end

  def create
    @accounts.create account_params
    redirect_to user_accounts_url(@user)
  end

  def update
    @user.accounts.find(params[:id]).update(account_params.except(:id))
    redirect_to :back
  end

  def destroy
    redirect_to user_accounts_url(@user)
  end

private

  def account_params
    params.required(:account).permit(:id, :name, :money)
  end

  def set_user
    @user = User.find params[:user_id]
  end

  def set_accounts
    @accounts = params[:month].presence ? @user.accounts.with_items_bought_in(params[:month]) : @user.accounts
  end
end
