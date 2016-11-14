class ForeignKeys < ActiveRecord::Migration
  def change
    add_reference :tenants, :property
    add_reference :tenants, :lease
    add_reference :properties, :account
    add_reference :units, :property
  end
end
