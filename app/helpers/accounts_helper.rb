module AccountsHelper
  def currency_info_for(account)
    { unit: account.currency }
  end
end
