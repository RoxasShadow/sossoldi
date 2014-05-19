class ItemsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user
  before_action :set_user
  before_action :set_account, except: %i(review monthly_review)
  before_action :set_items,   except: %i(review monthly_review)

  def create
    @items.create(item_params)

    redirect_to user_accounts_url(@user)
  end

  def destroy
    redirect_to user_accounts_url(@user)
  end

  def review
    @date, @items = review_data_for params[:date]

    @old_date, @old_items = review_data_for params[:old_date]
  end

  def monthly_review
    @month = params[:month].humanize.downcase
    @items = Item.bought_in(params[:month].to_sym, @user.items).sort_by &:bought_at

    if params[:old_month].present?
      @old_date  = params[:old_month].humanize.downcase
      @old_items = Item.bought_in(params[:old_month].to_sym, @user.items).sort_by &:bought_at
    end
  end

private

  def review_data_for(date)
    date = Date.strptime date, '%Y-%m-%d'
    
    h_date = humanize_date date
    h_date = h_date.to_s.humanize.downcase if h_date.is_a? Symbol

    items = Item.bought_the(date, @user.items).sort_by &:bought_at

    [h_date, items]
  end

  def item_params
    params.required(:item).permit(:name, :quantity, :price, :currency)
  end

  def set_user
    @user = User.find params[:user_id]
  end

  def set_account
    @account = @user.accounts.find params[:account_id]
  end

  def set_items
    @items = @account.items
  end
end
