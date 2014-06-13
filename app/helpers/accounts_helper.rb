module AccountsHelper
  def currency_info_for(account)
    { locale: account.currency.downcase.to_sym }
  end
end
