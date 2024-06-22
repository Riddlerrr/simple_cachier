require "offers/buy_one_get_one_free"

class Offers
  attr_reader :registered_offers

  def initialize
    @registered_offers = {}
  end

  def register(product_number:, offer:)
    offer_class = "Offers::#{offer}"
    @registered_offers[product_number.to_sym] = Object.const_get(offer_class).new
  end

  def apply_discount(item)
    return 0 unless @registered_offers.key?(item.product_number.to_sym)

    @registered_offers[item.product_number.to_sym].discount(item)
  end

  def empty?
    @registered_offers.empty?
  end

  def count
    @registered_offers.count
  end
end
