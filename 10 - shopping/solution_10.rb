PRICE_ROUND_PRECISION = 2

class Shopping

  def initialize
    # @items stores all items user entered
    @items = {}
    @shopping_total = 0.00
  end
  
  def get_user_input
    while true
      puts "Product Name: (please enter 'stop' to end shopping.)"
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
    item_number = 1
    print_header
    if !@items.empty?
      @items.each do | item_key, item_value |
        print_item item_number, item_key, item_value
        item_number += 1
        @shopping_total += (item_value["product_quantity"] * item_value["product_price"])
      end
    else
      puts "Shopping cart is empty!"
    end
    print_footer 
  end

  private
  def print_header
    puts "\nShopping Summary:\n"
    puts "-----------------\n"
  end

  def print_item item_number, item_key, item_value
    print "##{item_number} - #{item_key}"
    print " | Quantity: #{item_value["product_quantity"]}"
    print " | Item Price: #{item_value["product_price"]}"
    print " | Item Total Price: #{ (item_value["product_quantity"].to_f * item_value["product_price"].to_f).round(PRICE_ROUND_PRECISION) }\n"
  end

  def print_footer
    puts "-----------------\n"
    puts "Total Shopping Price: #{@shopping_total.round(PRICE_ROUND_PRECISION)}"
  end
end

shopping = Shopping.new
shopping.get_user_input