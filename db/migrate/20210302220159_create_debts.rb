class CreateDebts < ActiveRecord::Migration[6.1]
  def change
    create_table :debts do |t|
      t.integer :value
      t.string :title
      t.text :descp
      t.integer :u_id

      t.timestamps
    end
  end
end
