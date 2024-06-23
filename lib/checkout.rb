require "item"
require "offers"

class Checkout
  attr_reader :items, :offers

  def initialize(offers = {})
    @items = {}
    @offers = Offers.new
    offers.each { |product_code, offer| @offers.register(product_code: product_code, offer: offer) }
  end

  def scan(item)
    product_code = item.product_code.upcase.to_sym

    if @items.key?(product_code)
      @items[product_code] += item
    else
      @items[product_code] = item
    end

    @items[product_code].count
  end

  def total
    sum_wo_discount = @items.values.sum(&:amount)

    discount = 0
    items.values.each do |item|
      discount += offers.apply_discount(item)
    end
    (sum_wo_discount - discount).round(2)
  end
end
