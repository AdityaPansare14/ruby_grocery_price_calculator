# Grocery price calculator program using oop
class Grocery
    attr_accessor :item_name, :item_quantity, :item_discount_price, :price_without_discount
    def initialize(item_name, item_quantity)
      @items_details = {
        "milk" => { "price" => 3.97,"sale_price" => 2.50 },
        "bread" => { "price" => 2.17, "sale_price" => 2.0 }, 
        "apple" => { "price" => 0.89 },
        "banana" => { "price" => 0.99 }
      }
      @item_name = item_name
      @item_quantity = item_quantity
      @price_without_discount = calculate_price_without_discount
      @item_discount_price = calculate_item_discount_price
    end
    def calculate_price_without_discount
      return @items_details[@item_name]["price"] * @item_quantity
    end
  
    def calculate_item_discount_price
        case @item_name
        when "milk"
          sale_quantity = 2
          milk_price = calculator(@items_details[@item_name]["price"], @items_details[@item_name]["sale_price"],sale_quantity)
          return milk_price 
        when "bread"
          sale_quantity = 3
          bread_price = calculator(@items_details[@item_name]["price"], @items_details[@item_name]["sale_price"],sale_quantity)
          return bread_price
        when "banana"
          return @items_details[@item_name]["price"] * @item_quantity
        when "apple"
          return @items_details[@item_name]["price"] * @item_quantity
        end
    end
    def calculator(item_price, item_sale_price, sale_quantity)
      item_discount_price = 0 
        if @item_quantity < sale_quantity
          item_discount_price = item_price * @item_quantity
          return item_discount_price
        end
        if @item_quantity >= sale_quantity
            item_discount_price = ((item_sale_price * sale_quantity) * (@item_quantity / sale_quantity) ) + (item_price * (@item_quantity % sale_quantity))
          return item_discount_price
        end
    end
end

$total_after_discount = []
$total_before_discount = []
$items_purchased = []

def get_items
    puts "Please enter all the items purchased separated by a comma"
    $items_purchased = gets.chomp.split(',')
    single_item("milk") if $items_purchased.include?('milk')
    single_item( "bread") if $items_purchased.include?('bread')
    single_item("banana") if $items_purchased.include?('banana')
    single_item("apple") if $items_purchased.include?('apple')  
    generate_receipt
end

def single_item(item_name)
  quantity = $items_purchased.count(item_name)
  item = Grocery.new(item_name, quantity)
  $total_before_discount.push(item.price_without_discount)
  $total_after_discount.push(item.item_discount_price)
end

def generate_receipt
  puts"\n Total price: #{ $total_after_discount.sum.round(2)} "
  saved_amount = ($total_before_discount.sum - $total_after_discount.sum).round(2)
  puts "\n you saved #{saved_amount} on this transaction"
  puts "\n Thanks for visting us"
end

get_items
