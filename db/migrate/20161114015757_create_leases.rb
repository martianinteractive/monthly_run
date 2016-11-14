class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|
      t.text :terms
      t.date :starts_on
      t.integer :length_in_months
      t.string :signed_by
      t.integer :monthly_amount_in_cents

      t.timestamps null: false
    end
  end
end
