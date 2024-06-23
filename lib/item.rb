class Item
  class NotFound < StandardError; end

  AVAILABLE_ITEMS = {
    GR1: {product_code: :GR1, name: "Green tea", price: 3.11},
    SR1: {product_code: :SR1, name: "Strawberries", price: 5},
    CF1: {product_code: :CF1, name: "Coffee", price: 11.23}
  }
  attr_reader :product_code, :name, :price, :count

  def self.find(product_code)
    product_code = product_code.upcase.to_sym

    item = AVAILABLE_ITEMS.fetch(product_code)
    raise NotFound unless item

    new(product_code: item[:product_code], name: item[:name], price: item[:price])
  end

  def initialize(product_code:, name:, price:)
    @product_code = product_code
    @name = name
    @price = price
    @count = 1
  end

  def +(other)
    @count += 1
    self
  end

  def amount
    price * count
  end
end
