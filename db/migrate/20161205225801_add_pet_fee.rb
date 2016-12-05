class AddPetFee < ActiveRecord::Migration
  def change
    add_monetize :leases, :pet_fee
  end
end
