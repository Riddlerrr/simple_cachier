class Offers
  class BuyOneGetOneFree
    def initialize
      @name = "Buy 1 Get 1 Free"
    end

    attr_reader :name

    def discount(item)
      item.count / 2 * item.price
    end
  end
end
