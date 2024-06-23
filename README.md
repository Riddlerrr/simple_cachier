# Cashier
A simple cashier class that adds products to a cart and returns the total price. Can include offers with pricing rules.

## Example

```ruby
co = Checkout.new(pricing_rules)
co.scan("GR1")
co.scan("SR1")
price = co.total
=> 8.11
```

Offers can be added to the checkout class. The following offers are available:

- `BuyOneGetOneFree` => Buy one and get one free
- `BuyBulkWithFixedDiscount` => Buy 3 or more and get 0.5 discount
- `BuyBulkWithPercentageDiscount` => Buy 3 or more and get 1/3 discount to price of the product

Offers can be added to any Item available.

Example of checkout initialization with offers:

```ruby
offers = {
  "GR1" => "BuyOneGetOneFree",
  "SR1" => "BuyBulkWithFixedDiscount",
  "CF1" => "BuyBulkWithPercentageDiscount"
}
Checkout.new(offers)
```

## Available items

Product code | Name | Price
---|---|---
GR1 | Green tea | £3.11
SR1 | Strawberries | £5.00
CF1 | Coffee | £11.23

## Test data:
- Basket: GR1,SR1,GR1,GR1,CF1
  - Total price expected: ​£22.45
- Basket: GR1,GR1
  - Total price expected: ​£3.11
- Basket: SR1,SR1,GR1,SR1
  - Total price expected:​ £16.61
- Basket: GR1,CF1,SR1,CF1,CF1
  - Total price expected:​ £30.57

## Things that could be improved:
- Add Money gem to return amounts with currency
