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

  describe "#total" do
    subject(:total) { checkout.total }

    let(:checkout) { Checkout.new }

    context "when there is no item scanned" do
      it "returns 0" do
        is_expected.to eq 0
      end
    end

    context "when there are items scanned" do
      before do
        checkout.scan(FactoryBot.build(:item, :green_tea))
        checkout.scan(FactoryBot.build(:item, :strawberries))
        checkout.scan(FactoryBot.build(:item, :coffee))
      end

      it "returns the total price of all items" do
        is_expected.to eq 19.34 # 3.11 + 5 + 11.23
      end
    end

    context "when there are multiple items scanned" do
      before do
        checkout.scan(FactoryBot.build(:item, :green_tea))
        checkout.scan(FactoryBot.build(:item, :green_tea))
        checkout.scan(FactoryBot.build(:item, :strawberries))
        checkout.scan(FactoryBot.build(:item, :strawberries))
        checkout.scan(FactoryBot.build(:item, :strawberries))
        checkout.scan(FactoryBot.build(:item, :coffee))
      end

      it "returns the total price of all items" do
        is_expected.to eq 32.45 # 3.11 * 2 + 5 * 3 + 11.23
      end
    end
  end
end
