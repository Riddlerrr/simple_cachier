require "spec_helper"

RSpec.describe Checkout do
  describe ".new" do
    subject { Checkout.new }

    it "creates a new instance of Checkout" do
      is_expected.to be_an_instance_of(Checkout)
    end
  end

  describe "#scan" do
    subject(:scan) { checkout.scan(item) }

    let(:checkout) { Checkout.new }
    let(:item) { FactoryBot.build(:item) }

    it "can scan an item and add it into items list" do
      expect(checkout.items).to be_empty

      is_expected.to be 1

      expect(checkout.items.keys).to contain_exactly(item)
      expect(checkout.items[item]).to eq 1
    end

    context "when the item is already scanned" do
      before { checkout.scan(item) }

      it "can scan an item and increment the quantity" do
        expect(checkout.items).not_to be_empty

        is_expected.to be 2

        expect(checkout.items.keys).to contain_exactly(item)
        expect(checkout.items[item]).to eq 2
      end
    end
  end
end
