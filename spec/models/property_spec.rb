require 'rails_helper'

RSpec.describe Property, type: :model do

  context "property is the unit" do
    let(:property) { create(:property, is_rental_unit: true) }

    it { expect(property.units.count).to eq 1 }
  end

  context "property is not the unit" do
    let(:property) { create(:property, is_rental_unit: false) }

    it { expect(property.units.count).to eq 0 }
  end
end
