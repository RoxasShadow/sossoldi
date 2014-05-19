class AddTotalToItems < ActiveRecord::Migration
  def change
    add_column :items, :total, :float
  end
end
