require "item"
require "offers"

class Checkout
  attr_reader :items, :offers

  def initialize(offers = {})
    @items = {}
    @offers = Offers.new
    offers.each { |product_code, offer| @offers.register(product_code: product_code, offer: offer) }
  end

  def scan(product_code)
    item = Item.find(product_code)

    if @items.key?(item.product_code)
      @items[item.product_code] += item
    else
      @items[item.product_code] = item
    end

    @items[item.product_code].count
  end

  def total
    amount_wo_discount = @items.values.sum(&:amount)
    discount = items.values.sum { |item| offers.apply_discount(item) }

    (amount_wo_discount - discount).round(2)
  end
end
