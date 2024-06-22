class Offers
  class BuyBulkWithFixedDiscount
    BULK_SIZE = 3
    DISCOUNT = 0.5

    def initialize
      @name = "Buy 3 or more, to get a discount of 0.5 per item"
    end

    attr_reader :name

    def discount(item)
      return 0 unless item.count >= BULK_SIZE

      (item.count * DISCOUNT).round(2)
    end
  end
end
