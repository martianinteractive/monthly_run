class Account < ActiveRecord::Base
  has_many :properties
  has_many :tenants, dependent: :destroy
  has_many :users, dependent: :destroy
end
