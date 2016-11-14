class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :number
      t.text :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :dimension
      t.text :notes
      t.integer :issues_count, default: 0
      # t.references :property, index: true, foreign_key: true
      # t.references :unit_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
