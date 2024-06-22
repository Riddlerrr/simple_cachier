FactoryBot.define do
  factory :item do
    initialize_with { new(product_number: product_number, name: name, price: price) }

    product_number { "gr1" }
    name { "Green tea" }
    price { 3.11 }

    trait :green_tea do
      product_number { "gr1" }
      name { "Green tea" }
      price { 3.11 }
    end

    trait :strawberries do
      product_number { "sr1" }
      name { "Strawberries" }
      price { 5 }
    end

    trait :coffee do
      product_number { "cf1" }
      name { "Coffee" }
      price { 11.23 }
    end
  end
end
