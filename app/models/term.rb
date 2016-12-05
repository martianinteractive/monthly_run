class Term < ApplicationRecord
  belongs_to :lease
  belongs_to :active_lease, class_name: "Lease", foreign_key: :lease_id
  belongs_to :tenant
end
