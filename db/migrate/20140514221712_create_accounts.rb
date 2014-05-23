class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.float  :money, default: 0
      t.string :currency, default: 'EUR'

      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
