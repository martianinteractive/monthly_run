require 'rails_helper'

RSpec.describe Property, type: :model do

  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:account) }
  it { is_expected.to validate_presence_of(:unit_type) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:unit_type) }

  context "property is the unit" do
    let(:property) { create(:property, is_rental_unit: true) }

    it { expect(property.units.count).to eq 1 }
  end

  context "property is not the unit" do
    let(:property) { create(:property, is_rental_unit: false) }

    it { expect(property.units.count).to eq 0 }
  end
end
