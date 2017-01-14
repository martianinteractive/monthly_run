require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { is_expected.to validate_presence_of(:applicable_period) }
  it { is_expected.to validate_presence_of(:admin_user) }
end
