class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :name
      t.string   :details
      t.integer  :quantity, default: 1
      t.float    :price
      t.string   :currency, default: 'EUR'

      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end
  end
end
