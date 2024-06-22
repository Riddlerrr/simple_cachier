class Item
  attr_reader :product_number, :name, :price

  def initialize(product_number:, name:, price:)
    @product_number = product_number
    @name = name
    @price = price
  end
end
