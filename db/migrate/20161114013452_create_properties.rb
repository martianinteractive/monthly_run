class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.text :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :unit_name
      t.string :tax_number
      t.string :rent_due
      t.integer :units_count, default: 0
      #t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
