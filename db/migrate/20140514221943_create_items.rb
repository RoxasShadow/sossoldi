class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :name
      t.string   :details
      t.integer  :quantity
      t.float    :price
      t.string   :currency

      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end
  end
end
