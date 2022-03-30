PRICE_ROUND_PRECISION = 2

class Shopping

  def initialize
    # @items stores all items user entered
    @items = {}
    @shopping_total = 0.00
  end
  
  def start
    while true
      puts "Product Name:"
      product_name = gets.chomp.to_s

      if product_name == "stop"
        display_result
        break 
      end
      
      puts "product Price:"
      product_price = gets.chomp.to_f
      puts "product Quantity:"
      product_quantity = gets.chomp.to_f

      store_item(product_name, product_price, product_quantity)
    end
  end

  def store_item product_name, product_price, product_quantity
    @items[product_name] = { "product_price" => product_price, "product_quantity" => product_quantity }
  end

  # display final shopping summary
  def display_result
    puts "\nShopping Summary:\n"
    puts "-----------------\n"
    item_number = 1
    @items.each do | item_key, item_value |
      puts "##{item_number} - #{item_key} Quantity: #{item_value["product_quantity"]}, Item Price: #{item_value["product_price"]}, Item Total Price: #{ (item_value["product_quantity"].to_f * item_value["product_price"].to_f).round(PRICE_ROUND_PRECISION) }\n"
      item_number += 1
      @shopping_total += (item_value["product_quantity"] * item_value["product_price"])
    end
    puts "-----------------\n"
    puts "Total Shopping Price: #{@shopping_total.round(PRICE_ROUND_PRECISION)}"
  end
end

shop = Shopping.new
shop.start