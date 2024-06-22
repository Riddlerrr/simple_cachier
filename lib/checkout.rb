require "item"

class Checkout
  attr_reader :items

  def initialize
    @items = {}
  end

  def scan(item)
    if @items.key?(item)
      @items[item] += 1
    else
      @items[item] = 1
    end

    @items[item]
  end
end
