class Item < ActiveRecord::Base 
  before_save :set_total
  
  validates :name, :price, presence: true

  belongs_to :account
  
  alias_attribute :bought_at, :created_at

  default_scope { order('created_at DESC') }

  def set_total
    self.total = price * quantity
  end

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

    def bought_in(month, items = all)
      month = normalize_month month

      items.where('extract(month from items.created_at) = ? and extract(year from items.created_at) = ?', month, Date.today.year)
    end

    def bought_the(date, items = all)
      items.where('extract(year from items.created_at) = ? and extract(month from items.created_at) = ? and extract(day from items.created_at) = ?', date.year, date.month, date.day)
    end
  end
end
