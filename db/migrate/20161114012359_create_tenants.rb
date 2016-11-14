class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile
      t.string :work_phone
      t.string :home_phone
      t.text :notes
      t.references :property, index: true, foreign_key: true
      t.references :lease, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
