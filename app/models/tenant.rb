class Tenant < ActiveRecord::Base
  include FullNameSplitter
  
  belongs_to :property
  belongs_to :lease
end
