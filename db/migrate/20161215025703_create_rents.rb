class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.integer :rent_due_in_cents
      t.integer :rent_collected_in_cents
      t.string :month
      t.datetime :collected_at
      t.datetime :deposited_at
      t.string :received_via
      t.string :received_by
      t.text :notes

      t.timestamps null: false
    end
  end
end
