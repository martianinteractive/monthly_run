class Tenant < ActiveRecord::Base
  belongs_to :property
  belongs_to :lease
end
