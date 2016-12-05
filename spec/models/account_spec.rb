require 'rails_helper'

RSpec.describe Account, type: :model do

  it { is_expected.to have_many(:properties) }
  it { is_expected.to have_many(:users) }
end
