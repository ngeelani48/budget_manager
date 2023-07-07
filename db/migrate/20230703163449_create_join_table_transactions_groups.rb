class CreateJoinTableTransactionsGroups < ActiveRecord::Migration[7.0]
  def change
    create_join_table :transactions, :groups do |t|
       t.index [:transaction_id, :group_id]
       t.index [:group_id, :transaction_id]
    end
  end
end
