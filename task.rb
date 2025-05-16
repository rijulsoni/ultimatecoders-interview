class PriceCalculator
  ITEMS = {
    "Milk" => { unit: 3.97, sale: { quantity: 2, price: 5.00 } },
    "Bread" => { unit: 2.17, sale: { quantity: 3, price: 6.00 } },
    "Banana" => { unit: 0.99 },
    "Apple" => { unit: 0.89 }
  }

  def initialize(purchased_items)
    @items = purchased_items.map(&:capitalize)
    @item_counts = Hash.new(0)
    @items.each { |item| @item_counts[item] += 1 }
  end

  def calculate
    total_price = 0.0
    total_without_discount = 0.0

    puts "\nItem     Quantity     Price"
    puts "-" * 30

    @item_counts.each do |item, quantity|
      info = ITEMS[item]
      unit_price = info[:unit]
      sale = info[:sale]

      without_discount = quantity * unit_price
      total_without_discount += without_discount

      if sale
        sale_qty = sale[:quantity]
        sale_price = sale[:price]

        sets = quantity / sale_qty
        remainder = quantity % sale_qty

        final_price = sets * sale_price + remainder * unit_price
      else
        final_price = quantity * unit_price
      end

      total_price += final_price
      puts format("%-8s %-11d $%.2f", item, quantity, final_price)
    end

    puts "-" * 30
    puts format("Total price : $%.2f", total_price)
    puts format("You saved $%.2f today", total_without_discount - total_price)
  end
end

puts "Please enter all the items purchased separated by a comma:"
input = gets.chomp
items = input.split(',').map(&:strip)
calculator = PriceCalculator.new(items)
calculator.calculate
