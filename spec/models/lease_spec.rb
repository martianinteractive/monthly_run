require 'rails_helper'

RSpec.describe Lease, type: :model do

  it { is_expected.to belong_to(:unit) }
  it { is_expected.to have_many(:terms) }
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
 
end
