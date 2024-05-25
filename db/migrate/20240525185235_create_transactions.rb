class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :card_number
      t.decimal :amount
      t.date :card_expiry_date
      t.string :card_cvv
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
