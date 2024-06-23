describe Item do
  describe ".find" do
    subject(:find) { described_class.find(product_code) }

    context "when the product exists" do
      let(:product_code) { "GR1" }

      it "returns the item" do
        is_expected.to have_attributes(product_code: :GR1, name: "Green tea", price: 3.11, count: 1)
      end
    end

    context "when the product does not exist" do
      let(:product_code) { "XX1" }

      it "raises an error" do
        expect { find }.to raise_error(Item::NotFound)
      end
    end
  end

  describe "#+" do
    subject(:add) { item + other }

    let(:item) { described_class.new(product_code: :GR1, name: "Green tea", price: 3.11) }
    let(:other) { described_class.new(product_code: :GR1, name: "Green tea", price: 3.11) }

    it "increments the count" do
      expect { add }.to change { item.count }.by(1)
    end
  end

  describe "#amount" do
    subject(:amount) { item.amount }

    let(:item) { described_class.new(product_code: :GR1, name: "Green tea", price: 3.11) }

    it "returns the amount" do
      is_expected.to eq 3.11
    end
  end
end
