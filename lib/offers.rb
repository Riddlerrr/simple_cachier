require "offers/buy_one_get_one_free"
require "offers/buy_bulk_with_fixed_discount"
require "offers/buy_bulk_with_percentage_discount"

class Offers
  attr_reader :registered_offers

  def initialize
    @registered_offers = {}
  end

  def register(product_code:, offer:)
    offer_class = "Offers::#{offer}"
    @registered_offers[product_code.upcase.to_sym] = Object.const_get(offer_class).new
  end

  def apply_discount(item)
    return 0 unless @registered_offers.key?(item.product_code)

    @registered_offers[item.product_code].discount(item)
  end

  def empty?
    @registered_offers.empty?
  end

  def count
    @registered_offers.count
  end
end
