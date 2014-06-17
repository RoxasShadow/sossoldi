class ChangeDefaultCurrency < ActiveRecord::Migration
  def change
    change_column_default :users, :currency, '€'
  end
end
