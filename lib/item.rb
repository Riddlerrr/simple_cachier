class Item
  attr_reader :product_number, :name, :price, :count

  def initialize(product_number:, name:, price:)
    @product_number = product_number
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
