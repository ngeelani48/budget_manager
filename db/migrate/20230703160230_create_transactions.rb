class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
