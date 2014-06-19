class Item < ActiveRecord::Base 
  before_save { self.total = price * quantity }

  belongs_to :account

  alias_attribute :bought_at, :created_at

  validates :name, :price, presence: true

  default_scope { order('items.created_at desc') }
  scope :bought_the, -> (date, items = all) { items.where('extract(year from items.created_at) = ? and extract(month from items.created_at) = ? and extract(day from items.created_at) = ?', date.year, date.month, date.day) }
  scope :bought_in,  -> (month, items = all) { items.where('extract(month from items.created_at) = ? and extract(year from items.created_at) = ?', normalize_month(month), Date.today.year) }
  
  def name_and_quantity
    "#{name} (x#{quantity})"
  end

  class << self
    include ApplicationHelper

    def count_items(items = all)
      [].tap do |total|
        items.each do |item|
          total << item.quantity
        end
      end.inject :+
    end

    def left_money(items = all)
      [].tap do |money|
        [].tap do |accounts_used|
          items.each do |item|
            accounts_used << item.account
          end
        end.uniq.each do |account|
          money << account.left_money
        end
      end.inject(:+) - items.grand_total
    end

    def grand_total(items = all)
      [].tap do |total|
        items.each do |item|
          total << item.total
        end
      end.inject :+
    end
  end
end
