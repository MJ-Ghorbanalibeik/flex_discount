# FlexDiscount

An extensible and flexible discount implementation
This gem aims to implement a discount system for promotional campaigns or any other usage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flex_discount', :git => 'https://github.com/MJ-Ghorbanalibeik/flex_discount'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone git://github.com/MJ-Ghorbanalibeik/flex_discount.git
    $ cd flex_discount && rake build gem
    $ gem install flex_discount

## Usage

  1. Product & OrderItem
  Each Product has Id, name and price. They can be defined like this:

```ruby
Product.new(1, 'Burger', 7.99)
Product.new(2, 'Fries', 1.99)
Product.new(3, 'Salad', 2.99)
```

  OrderItem takes a product and a count. So if you want to order 3 Burgers:

```ruby
OrderItem.new(Product.new(1, 'Burger', 7.99), 3)
```

  2. Discount models
  Currenty 3 discount models are implemented:
    2.1. FlatDiscount
    Gives a flat percentage discount, if total value of order exceeds certain amount.
    For example this will give 10% discount if original value of order is greater than 30.

```ruby
FlatDiscount.new(10, 30)
```

    2.2. StepDiscount
    Gives step based discounts, based on percentage and threshold of each step.
    For example this will give 10% discount if original value is greater than 30, and less than 50. If original value of order exceeds 50 then this will give 15% discount.

```ruby
StepDiscount.new(10, 30).add_step(15, 50)
```

    2.3. ItemDiscount
    This model is more complex. It has a trigger item, a target item, and multiplications of both. Consider product examples.
    For example if you want to drop Burger price for each Burger to 5.99, if customer buys 3 or more Burgers, then use something like this:

```ruby
ItemDiscount.new(1, 3, 100 * (7.99 - 5.99)/7.99)
```

    Another example is when you want to drop price of 1 Fires 15% for each 2 Burgers that are in order:

```ruby
ItemDiscount.new(1, 2, 15, 2, 1, 2, 1)
```

  3. Checkout
  This class handles orders and discounts. Initialize it with an array of promotional rules:

```ruby
flat_discount = FlatDiscount.new(10, 30)
co = Checkout.new([flat_discount])
```

  You can also use multiple promotional rules:

```ruby
flat_discount = FlatDiscount.new(10, 30)
item_discount = ItemDiscount.new(1, 3, 100 * (7.99 - 5.99)/7.99)
co = Checkout.new([item_discount, flat_discount])
```

  Note that order of promotional rules are important. Checkout class uses this order to calculate correct discount.

  Add order items with scan method:

```ruby
co.scan OrderItem.new(Product.new(1, 'Burger', 7.99), 2)
co.scan OrderItem.new(Product.new(2, 'Fires', 1.99), 1)
co.scan OrderItem.new(Product.new(1, 'Burger', 7.99))
```

  Note that count of product is optional and defaults to 1. Also you can add order items without any sort.

  Get final price of order (with applied discounts):

```ruby
co.total
```

## Development

If you want to implement another discount model, just subclass BaseDiscount and do not forget to override calculate_discount method.

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MJ-Ghorbanalibeik/flex_discount.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
