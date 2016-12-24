require 'rails_helper'

RSpec.describe RentReceiver, "with default options" do

  let(:lease) { create(:lease) }
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


end
