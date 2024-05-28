class AddCardExpiryMonthAndYearToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :card_expiry_month, :integer
    add_column :transactions, :card_expiry_year, :integer
    remove_column :transactions, :card_expiry_date, :date
  end
end
