require 'rails_helper'

RSpec.describe Tenant, type: :model do

  context "property is the unit" do
    let(:lease) { create(:lease, starts_on: (Date.today - 12.months), length_in_months: 6)}
    let(:property) { create(:property, is_rental_unit: true) }

    it { expect(property.units.count).to eq 1 }
  end
end
