class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.float  :money
      t.string :currency

      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
