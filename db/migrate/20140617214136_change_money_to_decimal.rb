class ChangeMoneyToDecimal < ActiveRecord::Migration
  def change
    change_column :accounts, :money, :decimal
  end
end
