require 'rails_helper'

RSpec.describe RentReceiver, "with default options" do

  let(:charge) { create(:charge, amount: 0) }
  let(:lease) { create(:lease, charges: [charge]) }
  let(:rent_receiver) { RentReceiver.new(lease) }
  
  it { expect { RentReceiver.new }.to raise_error(ArgumentError)  }

  it { expect { RentReceiver.new('') }.to raise_error(ArgumentError) }

  it { expect(rent_receiver).to be_a(RentReceiver) }

  it { expect(rent_receiver.amount_due).to eq Money.new(0) }

  it { expect(rent_receiver.admin_user).to eq nil }

  it { expect(rent_receiver.amount_collected).to eq Money.new(0) }

  it { expect(rent_receiver.collected_on.to_s).to eq Time.zone.now.to_date.to_s }

  it { expect(rent_receiver.received_via).to eq nil }

  it { expect(rent_receiver.applicable_period.to_s).to eq Time.zone.now.to_date.to_s }

end


RSpec.describe RentReceiver do

  let(:lease) { create(:lease) }

  context "passing a date object  as applicable_period param" do

    let(:rent_receiver) { RentReceiver.new(lease, applicable_period: 1.month.from_now) }

    it { expect(rent_receiver.applicable_period.to_s).to eq((Time.zone.now + 1.month).to_s) }

  end

  context "passing a string as applicable_period param" do

    let(:rent_receiver) { RentReceiver.new(lease, applicable_period: "next month") }

    it { expect(rent_receiver.applicable_period.to_s).to eq(Chronic.parse('next month').to_s) }

  end

  context "receiving full payment" do
    let(:admin_user) { create(:admin_user) }
    let(:security_deposit) { create(:charge, name: "security deposit", frequency: "one_time", amount: "500") }
    let(:rent) { create(:charge, name: "rent", frequency: "monthly", amount: "1200") }
    let(:lease) { create(:lease, charges: [security_deposit, rent]) }

    it 'creates payment records' do
      expect { 
        RentReceiver.process_full_payment!(lease, {admin_user: admin_user}) 
        }.to change { Payment.count }.by(2)
    end
  end

end
