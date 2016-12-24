class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :lease, index: true, foreign_key: true
      t.string :name
      t.integer :amount_due_in_cents, default: 0, null: false
      t.string :amount_due_currency, default: "USD", null: false
      t.integer :amount_collected_in_cents, default: 0, null: false
      t.string :amount_collected_currency, default: "USD", null: false
      t.date :collected_on
      t.date :deposited_on
      t.string :received_via
      t.references :admin_user, index: true, foreign_key: true
      t.date :applicable_period
      t.references :charge, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
