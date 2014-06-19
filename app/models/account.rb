class Account < ActiveRecord::Base
  belongs_to :user
  has_many   :items
  
  validates :name, presence: true

  default_scope { order('accounts.created_at desc') }
  scope :with_items_bought_in, -> (month, accounts = all) { accounts.select { |account| account.items.bought_in(month).any? } }

  def left_money(abs = true)
    left_money = money - items.sum(:total)
    abs ? money.abs : left_money
  end
end
