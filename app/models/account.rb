class Account < ActiveRecord::Base
  has_many :properties, dependent: :destroy
  has_many :users, dependent: :destroy
end
