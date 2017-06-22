require 'rails_helper'

RSpec.describe Lease, type: :model do

  it { is_expected.to belong_to(:unit) }
  it { is_expected.to have_many(:terms) }
  it { is_expected.to have_many(:charges) }
  it { is_expected.to have_many(:payments) }
  it { is_expected.to have_many(:tenants).through(:terms) }
  it { is_expected.to have_many(:one_time_charges) }
  it { is_expected.to have_many(:periodic_charges) }

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
    expect(lease.ends_on).to eq((Date.tomorrow - 1.day))
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

  context "charges" do
    let(:user) { create(:admin_user) }
    let(:unit) { create(:unit) }
    let(:security_deposit) { build(:charge, name: "Security Deposit", amount: "900", frequency: "one_time") }
    let(:pet_fee) { build(:charge, name: "Pet Fee", amount: "30", frequency: "monthly") }
    let(:rent) { build(:charge, name: "Rent", amount: "400", frequency: "monthly") }
    let(:lease) { create(:lease, unit: unit, charges: [security_deposit, pet_fee, rent]) }

    it "includes rent as periodic charge" do
      expect(lease.periodic_charges).to include(rent)  
    end

    it "includes pet_fee as periodic charge" do
      expect(lease.periodic_charges).to include(pet_fee)
    end

    it "returns the sum of all unpaid periodic charges" do
      expect(lease.periodic_charges.unpaid.total_amount).to eq Money.new(43000)
    end

    it "returns unpaid periodic charges" do
      expect(lease.periodic_charges.unpaid).to eq([pet_fee, rent])
    end

    it "returns an empty array since no payments have been made" do
      expect(lease.periodic_charges.paid).to be_empty
    end

    it "returns the sum of all charges due for the period" do
      expect(lease.total_period_amount_due(Time.zone.now.to_date)).to eq Money.new(133000)
    end

    it "returns 0 dollars as the period amount paid" do
      expect(lease.total_period_amount_paid(Time.zone.now.to_date)).to eq Money.new(0)
    end

    it "returns the amount due" do
      expect(lease.amount_due(Time.zone.now.to_date)).to eq Money.new(133000)
    end

    it "returns 0 dollars" do
      expect(lease.amount_paid(Time.zone.now.to_date)).to eq Money.new(0)
    end

    it "does not include the rent when it has been paid" do
      create(:payment, lease: lease, charge: rent, admin_user: user, applicable_period: Time.zone.today)
      expect(lease.periodic_charges.unpaid).to_not include(rent)
    end

    context "when rent for the period has been paid" do
      before do
        create(:payment, lease: lease, charge: rent, admin_user: user, applicable_period: Time.zone.today)
      end

      it "does not include the rent charge as unpaid" do
        expect(lease.periodic_charges.unpaid).to_not include(rent)  
      end

      it "excludes the rent amount in the total" do
        expect(lease.periodic_charges.unpaid.total_amount).to eq pet_fee.amount
      end
    end

    context "one time charges" do

      it "includes security deposit as one time charge" do
        expect(lease.one_time_charges).to include(security_deposit)
      end

      it "includes unpaid one time charges" do
        expect(lease.one_time_charges.unpaid).to eq([security_deposit])
        expect(lease.one_time_charges.paid).to be_empty
      end

      it "returns the amount of one time charges" do
        expect(lease.one_time_charges.unpaid.total_amount).to eq Money.new(90000)
      end

      it "does not include paid one time charges when they are paid" do
        create(:payment, lease: lease, charge: security_deposit, admin_user: user, applicable_period: Time.zone.today)
        expect(lease.one_time_charges.unpaid).to be_empty
      end

      it "" do
        create(:payment, lease: lease, charge: security_deposit, admin_user: user, applicable_period: Time.zone.today)
        expect(lease.one_time_charges.unpaid.total_amount).to eq Money.new(0)
      end

    end
  end

  context "leases payable and paid scopes" do
    let(:security_deposit) { create(:charge, name: "Security Deposit", amount: "900", frequency: "one_time") }
    let(:pet_fee) { create(:charge, name: "Pet Fee", amount: "30", frequency: "monthly") }
    let(:rent) { create(:charge, name: "Rent", amount: "400", frequency: "monthly") }
    let(:unit) { create(:unit) }
    let(:lease) { create(:lease, charges: [pet_fee, rent, security_deposit], unit: unit) }

    it pending

  end

  context "monthly balance" do
    let(:rent) { build(:charge, name: "Rent", amount: "500", frequency: "monthly") }
    let(:unit) { create(:unit) }
    let!(:lease) { create(:lease, starts_on: 1.year.ago, charges: [rent]) }

    it "returns leases with a monthly balance ?from past unpaid rents?" do
      expect(Lease.monthly_balance).to eq("")   
    end
    
  end
 
end
