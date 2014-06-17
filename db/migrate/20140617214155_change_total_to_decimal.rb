class ChangeTotalToDecimal < ActiveRecord::Migration
  def change
    change_column :items, :total, :decimal
  end
end
