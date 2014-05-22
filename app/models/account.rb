class Account < ActiveRecord::Base
  include Money

  validates :name, :money, :currency, presence: true

  belongs_to :user
  has_many   :items
  
  default_scope { order('created_at DESC') }

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
    def with_items_bought_in(month, accounts = all)
      accounts.select { |account| account.items.bought_in(month).any? }
    end
  end
end
