class Offers
  class BuyBulkWithPercentageDiscount
    BULK_SIZE = 3
    DISCOUNT = 0.33

    def initialize
      @name = "Buy 3 or more, to get a 33% discount"
    end

    attr_reader :name

    def discount(item)
      return 0 unless item.count >= BULK_SIZE

      item.price * item.count * DISCOUNT
    end
  end
end
