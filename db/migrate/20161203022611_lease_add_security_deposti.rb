class LeaseAddSecurityDeposti < ActiveRecord::Migration
  def up
    add_monetize :leases, :security_deposit
  end

  def down
    remove_monetize :leases, :security_deposit
  end

end
