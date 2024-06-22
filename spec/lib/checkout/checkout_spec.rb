require "spec_helper"

RSpec.describe Checkout do
  describe ".new" do
    subject { Checkout.new }

    it "creates a new instance of Checkout" do
      is_expected.to be_an_instance_of(Checkout)

      expect(subject.items).to be_empty
      expect(subject.offers).to be_empty
    end

    context "when offers are provided" do
      let(:offers) { {"GR1" => "BuyOneGetOneFree"} }

      subject { Checkout.new(offers) }

      it "creates a new instance of Checkout with offers" do
        is_expected.to be_an_instance_of(Checkout)

        expect(subject.items).to be_empty
        expect(subject.offers).to be_an_instance_of(Offers)
        expect(subject.offers.count).to eq 1
      end
    end
  end

  describe "#scan" do
    subject(:scan) { checkout.scan(item) }

    let(:checkout) { Checkout.new }
    let(:item) { FactoryBot.build(:item) }

    it "can scan an item and add it into items list" do
      expect(checkout.items).to be_empty

      is_expected.to be 1

      expect(checkout.items.keys).to contain_exactly(:GR1)
      expect(checkout.items[:GR1].count).to eq 1
    end

    context "when the item is already scanned" do
      before { checkout.scan(FactoryBot.build(:item)) }

      it "can scan an item and increment the quantity" do
        expect(checkout.items).not_to be_empty

        is_expected.to be 2

        expect(checkout.items.keys).to contain_exactly :GR1
        expect(checkout.items[:GR1].count).to eq 2
      end
    end
  end

  describe "#total" do
    subject(:total) { checkout.total }

    context "when no offers are registered" do
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

    context "when offers are registered" do
      let(:checkout) { Checkout.new(offers) }

      context "buy one get one free" do
        let(:offers) { {"GR1" => :BuyOneGetOneFree} }

        before do
          checkout.scan(FactoryBot.build(:item, :green_tea))
          checkout.scan(FactoryBot.build(:item, :strawberries))
          checkout.scan(FactoryBot.build(:item, :green_tea))
        end

        it "returns the total price of all items with discount" do
          is_expected.to eq 8.11 # 3.11 + 5 - 3.11 (discount)
        end
      end

      context "buy bulk with fixed discount" do
        let(:offers) { {"SR1" => :BuyBulkWithFixedDiscount} }

        before do
          checkout.scan(FactoryBot.build(:item, :strawberries))
          checkout.scan(FactoryBot.build(:item, :strawberries))
          checkout.scan(FactoryBot.build(:item, :strawberries))
          checkout.scan(FactoryBot.build(:item, :green_tea))
          checkout.scan(FactoryBot.build(:item, :strawberries))
        end

        it "returns the total price of all items with discount" do
          is_expected.to eq 21.11 # 5 * 4 + 3.11 - 2 (4 * 0.5 discount)
        end
      end

      context "buy bulk with percentage discount" do
        let(:offers) { {"CF1" => :BuyBulkWithPercentageDiscount} }

        before do
          checkout.scan(FactoryBot.build(:item, :coffee))
          checkout.scan(FactoryBot.build(:item, :coffee))
          checkout.scan(FactoryBot.build(:item, :green_tea))
          checkout.scan(FactoryBot.build(:item, :coffee))
          checkout.scan(FactoryBot.build(:item, :coffee))
        end

        it "returns the total price of all items with discount" do
          is_expected.to eq 33.21 # 11.23 * 4 + 3.11 - 14.82 (11.23 * 4 * 0.33 discount)
        end
      end
    end
  end
end
