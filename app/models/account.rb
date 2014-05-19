class Account < ActiveRecord::Base
  include Money

  validates :name, :money, :currency, presence: true

  belongs_to :user
  has_many   :items

  # def money
  #   self.money || 0
  # end

  # def currency
  #   self.currency || 'EUR'
  # end

  def left_money
    money - items.sum(:total)
  end

  def print_left_money(abs = true)
    m = abs ? left_money.abs : left_money
    pretty_money_printing m, currency
  end

  class << self
    include CurrencyHelper

    # def grand_total_of(accounts)
    #   [].tap do |total|
    #     accounts.each do |account|
    #       total << account.items.sum(:total)
    #     end
    #   end.inject :+
    # end

    # def print_grand_total_of(accounts)
    #   pretty_money_printing grand_total_of(accounts), accounts.first.currency
    # end
  end
end
