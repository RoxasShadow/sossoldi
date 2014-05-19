class Item < ActiveRecord::Base
  include Money
  
  before_save :set_total
  
  validates :name, :quantity, :price, :currency, presence: true
  
  alias_attribute :bought_at, :created_at

  belongs_to  :account

  # def quantity
  #   self.quantity || 1
  # end

  # def currency
  #   self.currency || 'EUR'
  # end

  def set_total
    self.total = price * quantity
  end

  def name_and_quantity
    "#{name} (x#{quantity})"
  end

  class << self
    include CurrencyHelper

    def left_money_after(items)
      [].tap do |money|
        [].tap do |accounts_used|
          items.each do |item|
            accounts_used << item.account
          end
        end.uniq.each do |account|
          money << account.left_money
        end
      end.inject(:+) - grand_total_of(items)
    end

    def grand_total_of(items)
      [].tap do |total|
        items.each do |item|
          total << item.total
        end
      end.inject :+
    end

    %i(left_money_after grand_total_of).each do |m|
      define_method("print_#{m}") do |items, abs = false|
        money = abs ? send(m, items).abs : send(m, items)
        pretty_money_printing money, items.first.currency # TODO: currency
      end
    end

    def bought_in(month, items)
      month = case month
        when :this_month         then Date.today.month
        when :the_last_month     then Date.today.month - 1
        when :the_previous_month then Date.today.month - 1
        else month.to_s.to_i # TODO: accept "may"
      end

      items.select { |item| item.bought_at.month == month && item.bought_at.year == Date.today.year }
    end

    def bought_the(date, items)
      items.select do |item|
        y = item.bought_at.year  == date.year
        m = item.bought_at.month == date.month
        d = item.bought_at.day   == date.day
        
        y && m && d
      end
    end
  end
end
