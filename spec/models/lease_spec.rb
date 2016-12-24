require 'rails_helper'

RSpec.describe Lease, type: :model do

  it { is_expected.to belong_to(:unit) }
  it { is_expected.to have_many(:terms) }
  it { is_expected.to have_many(:charges) }
  it { is_expected.to have_many(:payments) }
  it { is_expected.to have_many(:tenants).through(:terms) }

  it { is_expected.to accept_nested_attributes_for(:tenants) }

  it { is_expected.to validate_presence_of(:starts_on) }
  it { is_expected.to validate_presence_of(:length_in_months) }

  context "active/inactive" do

    let(:active) { create(:lease, starts_on: 1.month.ago, length_in_months: 6 ) }
    let(:inactive) { create(:lease, starts_on: 1.year.ago, length_in_months: 1 ) }
    
    it "active scope returns active leases" do
      expect(Lease.active).to eq([active])
    end

    it "returns inative leases" do
      expect(Lease.inactive).to eq([inactive])
    end
  end

  context "leases a day before and after they expire" do
    
    it "" do
      inactive = create(:lease, starts_on: 1.year.ago, length_in_months: 12 )
      active = create(:lease, starts_on: (1.year.ago + 1.day), length_in_months: 12 )
      expect(Lease.active).to eq([active])
      expect(Lease.inactive).to eq([inactive])
    end

  end

  it "calculates the end of the lease" do
    lease = create(:lease, starts_on: 1.year.ago, length_in_months: 12)
    expect(lease.ends_on).to eq(Date.today)
  end

  describe "validating starts on" do
    it "validates starts on" do
      lease = build(:lease, starts_on: 1)
      lease.valid?
      expect(lease.errors[:starts_on]).to eq(["is not a valid date"])
    end

    it "empty gets caught by presence validator" do
      lease = build(:lease, starts_on: "")
      lease.valid?
      expect(lease.errors[:starts_on]).to_not include("is not a valid date")
    end

    it "nil gets caught by presence validator" do
      lease = build(:lease, starts_on: nil)
      lease.valid?
      expect(lease.errors[:starts_on]).to_not include("is not a valid date")
    end
  end

  describe "validating length in months" do
    it "is invalid with 0 months" do
      lease = build(:lease, length_in_months: 0)
      lease.valid?
      expect(lease.errors[:length_in_months]).to eq(["is not included in the list"])
    end

    it "is valid with 1 month" do
      lease = build(:lease, length_in_months: 1)
      lease.valid?
      expect(lease.errors[:length_in_months]).to eq([])
    end

    it "cannot be nil - does not trigger integer validation" do
      lease = build(:lease, length_in_months: nil)
      lease.valid?
      expect(lease.errors[:length_in_months]).to eq(["can't be blank"])
    end

    it "cannot be blank - does not trigger integer validation" do
      lease = build(:lease, length_in_months: "")
      lease.valid?
      expect(lease.errors[:length_in_months]).to eq(["can't be blank"])
    end

    it "cannot be blank - does not trigger integer validation" do
      lease = build(:lease, length_in_months: 1.4)
      lease.valid?
      expect(lease.errors[:length_in_months]).to eq(["must be an integer"])
    end
  end

  context "" do
    let(:pet_fee) { create(:charge, name: "Pet Fee", amount: "30", frequency: "monthly") }
    let(:rent) { create(:charge, name: "Rent", amount: "400", frequency: "monthly") }
    let(:unit) { create(:unit) }
    let(:lease) { create(:lease, charges: [pet_fee, rent], unit: unit) }

    it { expect(lease.periodic_charge_amount).to eq Money.new(43000) }
  end
 
end
