module CurrencyHelper
  def format_money(money, force_sign = false)
    money = case
      when money == money.to_i                   then money.round
      when money.to_s.split(?.).last.length == 1 then "#{money}0"
      else money.round 2
    end

    force_sign ? force_sign_for(money) : money
  end

  def get_symbol_for(currency)
    case currency.upcase
      when 'EUR' then '€'
      when 'USD' then '$'
      when 'GBP' then '£'
      else currency
    end
  end
end