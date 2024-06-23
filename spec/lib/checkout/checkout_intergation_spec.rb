require "spec_helper"

RSpec.describe Checkout do
  context "real-life scenarios" do
    subject(:total) { checkout.total }

    let(:checkout) { Checkout.new(offers) }
    let(:offers) do
      {"GR1" => "BuyOneGetOneFree",
       "SR1" => "BuyBulkWithFixedDiscount",
       "CF1" => "BuyBulkWithPercentageDiscount"}
    end

    context "basket GR1,SR1,GR1,GR1,CF1" do
      before do
        checkout.scan("GR1")
        checkout.scan("SR1")
        checkout.scan("GR1")
        checkout.scan("GR1")
        checkout.scan("CF1")
      end

      it "returns the total price" do
        is_expected.to eq 22.45
      end
    end

    context "basket GR1,GR1" do
      before do
        checkout.scan("GR1")
        checkout.scan("GR1")
      end

      it "returns the total price" do
        is_expected.to eq 3.11
      end
    end

    context "basket SR1,SR1,GR1,SR1" do
      before do
        checkout.scan("SR1")
        checkout.scan("SR1")
        checkout.scan("GR1")
        checkout.scan("SR1")
      end

      it "returns the total price" do
        is_expected.to eq 16.61
      end
    end

    context "basket GR1,CF1,SR1,CF1,CF1" do
      before do
        checkout.scan("GR1")
        checkout.scan("CF1")
        checkout.scan("SR1")
        checkout.scan("CF1")
        checkout.scan("CF1")
      end

      it "returns the total price" do
        is_expected.to eq 30.57
      end
    end
  end
end
