class Account < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  has_many   :items
  
  default_scope { order('created_at DESC') }

  def left_money(abs = true)
    left_money = money - items.sum(:total)
    abs ? money.abs : left_money
  end

  class << self
    def with_items_bought_in(month, accounts = all)
      accounts.select { |account| account.items.bought_in(month).any? }
    end
  end
end
