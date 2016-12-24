require 'rails_helper'

RSpec.describe Charge, type: :model do
  it { is_expected.to belong_to(:lease) }
  it { is_expected.to have_many(:payments) }

  it { is_expected.to validate_presence_of(:name) }
end
