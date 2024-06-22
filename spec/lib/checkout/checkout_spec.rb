require "spec_helper"

RSpec.describe Checkout do
  describe "#new" do
    subject { Checkout.new }

    it "creates a new instance of Checkout" do
      is_expected.to be_an_instance_of(Checkout)
    end
  end
end
