require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { is_expected.to validate_presence_of(:applicable_period) }
  it { is_expected.to validate_presence_of(:admin_user) }

  describe "for month" do
    let!(:lease)  { create(:lease) }
    let!(:charge) { create(:charge, lease: lease) }
    let!(:payment) { create(:payment, lease: lease, charge: charge, applicable_period: '2016-12-23') }

    it "defaults to current month" do
      expect(Payment.for_month).to be_empty
    end

    it "finds the matching payment with the first day of the matching month" do
      expect(Payment.for_month('2016-12-01')).to eq([payment])
    end

    it "finds the matching payment with the last day of the matching month" do
      expect(Payment.for_month('2016-12-31')).to eq([payment])
    end

    it "does not find the anything" do
      expect(Payment.for_month('2016-11-30')).to be_empty
    end

    it "returns the first payment matching" do
      expect(Payment.for_period('2016-12-31')).to eq(payment)
    end

    it "using association" do
      expect(lease.payments.for_period('2016-12-01')).to eq(payment)
    end
  end
end
