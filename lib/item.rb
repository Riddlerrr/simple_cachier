class Item
  attr_reader :product_number, :name, :price, :count


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
