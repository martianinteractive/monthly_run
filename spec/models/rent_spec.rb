require 'rails_helper'

RSpec.describe Rent, type: :model do
  it { is_expected.to belong_to(:lease) }
end
