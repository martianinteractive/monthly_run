class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string :name
      t.string :frequency
      t.integer :amount_in_cents
      t.string :amount_currency
      t.references :lease
      t.timestamps null: false
    end
  end
end
