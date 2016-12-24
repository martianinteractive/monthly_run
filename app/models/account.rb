class Account < ActiveRecord::Base
  has_many :properties, dependent: :destroy
  has_many :users, dependent: :destroy
  belongs_to :admin_user

  validates :name, presence: true
end
