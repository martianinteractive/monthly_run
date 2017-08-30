require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { create(:unit) }
  let(:charge) { create(:charge, lease: lease) }
  let(:payment) { create(:payment, charge: charge, lease: lease) }

  context "past payments" do
    let!(:lease) { create(:lease, :expired, unit: unit) }

    it "returns payments from past leases" do
      expect(unit.past_payments).to eq([payment])
    end
  end

  context "current payments" do
    let!(:lease) { create(:lease, :current, unit: unit) }

    it "returns payments from current leases" do
      expect(unit.past_payments).to eq([payment])
    end
  end

end
