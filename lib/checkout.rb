require "item"
require "offers"

class Checkout
  attr_reader :items, :offers

  def initialize(offers = {})
    @items = {}
    @offers = Offers.new
    offers.each { |product_number, offer| @offers.register(product_number: product_number, offer: offer) }
  end

  def scan(item)
    product_number = item.product_number.upcase.to_sym

    if @items.key?(product_number)
      @items[product_number] += item
    else
      @items[product_number] = item
    end

    @items[product_number].count
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
