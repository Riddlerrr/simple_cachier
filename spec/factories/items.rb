FactoryBot.define do
  factory :item do
    initialize_with { new(product_code: product_code, name: name, price: price) }

    product_code { "GR1" }
    name { "Green tea" }
    price { 3.11 }

    trait :green_tea do
      product_code { "GR1" }
      name { "Green tea" }
      price { 3.11 }
    end

    trait :strawberries do
      product_code { "SR1" }
      name { "Strawberries" }
      price { 5 }
    end

    trait :coffee do
      product_code { "CF1" }
      name { "Coffee" }
      price { 11.23 }
    end
  end
end
