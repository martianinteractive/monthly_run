class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :units_count, default: 0
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
