require 'pp'

test_cart =   [
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "KALE", :price => 3.00, :clearance => false},
      {:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
      {:item => "ALMONDS", :price => 9.00, :clearance => false},
      {:item => "TEMPEH", :price => 3.00, :clearance => true, :count => 7},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      # {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
      {:item => "TEMPEH", :price => 3.00, :clearance => true},
      {:item => "BEETS", :price => 2.50, :clearance => false},
      {:item => "SOY MILK", :price => 4.50, :clearance => true},
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
      {:item => "AVOCADO", :price => 3.00, :clearance => true}
    ]

test_coupons =  [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  for item in collection do
    if item[:item] === name
      return item
    end
  end
  
  nil
end


def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  consolidated_cart = []
  
  for item in cart do
    name = item[:item] #"PEANUTBUTTER"
    
    if !find_item_by_name_in_collection(name, consolidated_cart)
      item_with_count = item.clone
      item_with_count[:count] = 1
      
      consolidated_cart << item_with_count
    elsif find_item_by_name_in_collection(name, consolidated_cart) #"PEANUTBUTTER"
      item_in_cart = find_item_by_name_in_collection(name, consolidated_cart)
      
      item_in_cart[:count] += 1
    end
    
  end

  return consolidated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  for coupon in coupons do
    name = coupon[:item]
    coupon_amount = coupon[:num]
    item_in_cart = find_item_by_name_in_collection(name, cart)
    
    if item_in_cart && item_in_cart[:count] >= coupon_amount
      # times_coupon_applied = item_in_cart[:count] / coupon_amount
      remainder = item_in_cart[:count] % coupon_amount
      
      discounted_item = item_in_cart.clone
      discounted_item[:item] = "#{name} W/COUPON"
      discounted_item[:price] = coupon[:cost]/coupon[:num]
      discounted_item[:count] -= remainder
      
      cart << discounted_item
      
      item_in_cart[:count] = remainder
    end
  end
  
  return cart
end



def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  for item in cart do
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(2)
    end
  end
  
  return cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  total = 0.0
  
  cart_after_coupons_and_clearance_applied = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  for item in cart_after_coupons_and_clearance_applied do
    item_total = item[:price] * item[:count]
    total += item_total
  end
  
  if total > 100
    total *= 0.9
  end
  
  return total.round(2)
end

# pp checkout(test_cart, test_coupons)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# def find_item_by_name_in_collection(name, collection)
# #  collection.each do |hash_item|
# #   if name == hash_item[:item]
# #     return hash_item
# #   end
# #  end
# #  nil
# i = 0
# while i < collection.length
#   if  collection[i][:item] === name
#     return collection[i]
#   end
#   i+=1
# end
# end

# def consolidate_cart(cart)
#   # Consult README for inputs and outputs
#   #
#   # REMEMBER: This returns a new Array that represents the cart. Don’t merely
#   # change `cart` (i.e. mutate) it. It’s easier to return a new thing.
#   ##############################
# #   newcart = []
# #   cart.map do |hash_item|
# #     if !find_item_by_name_in_collection(hash_item[:item],newcart)
# #        hash_item [:count]=1
# #        newcart << hash_item
# #     else
# #       hash_item [:count]+=1
# #       newcart<< hash_item
# #     end
# #   end
# #   newcart
# # end
#   newcart = []
#   i=0
  
#   while i<cart.length
#   if ! find_item_by_name_in_collection(cart[i][:item],newcart)
#       cart[i][:count] = 1
#       newcart<< cart[i]
#   else #if item is already in new cart
#     original_item = find_item_by_name_in_collection(cart[i][:item],cart)
#     original_item[:count] += 1
#     # newcart<< original_item
#   end
#   i+=1
# end
#   newcart
# end

# # def apply_coupons(cart, coupons)
# #   consolidated_cart = consolidate_cart(cart)
  
# #   # consolidated_cart
  
# #   counter=0
# #   while counter < coupons.length
# #     pp "test1"
# #     cart_item = find_item_by_name_in_collection(coupons[counter][:item],consolidated_cart) # {:item=>"AVOCADO", :price=>3.0, :clearance=>true}
    
# #     couponed_item_name = "#{coupons[counter][:item]} W/COUPON" # "AVOCADO W/COUPON"
    
# #     p  find_item_by_name_in_collection(couponed_item_name,consolidated_cart) # nil
    
# #     cart_item_with_coupon= find_item_by_name_in_collection(couponed_item_name,consolidated_cart)
    
# #     pp cart_item # {:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>5}
# #     # cart_item[:count] => 5
# #     # coupons[counter][:num] => 2
    
# #     if cart_item && cart_item[:count]>= coupons[counter][:num] #item exists in consolidated_cart && count > coupon num
# #       pp "test2"
# #       pp consolidated_cart
# #       if cart_item_with_coupon #couponed_item_name exists in consolidated_cart
# #         cart_item_with_coupon[:count]+=coupons[counter][:num]
# #         cart_item[:count] -= coupons[counter][:num]
# #       else #couponed_item_name does not exist in consolidated_cart
# #         pp "test3"
        
        
# #         cart_item_with_coupon = {
# #           item: couponed_item_name,
# #           price: coupons[counter][:cost]/coupons[counter][:num],
# #           clearance: cart_item[:clearance],
# #           count: coupons[counter][:num]
# #         }
        
# #         consolidated_cart << cart_item_with_coupon
# #         pp cart_item_with_coupon #=> nil
# #         cart_item_with_coupon[:item] = couponed_item_name
# #         cart_item_with_coupon[:price] = coupons[counter][:cost]/coupons[counter][:num]
# #         pp "test4"
# #       end
      
      
# #     end
# #     counter+=1
# #   end
  
# #   pp consolidated_cart
# # end

# def apply_coupons(cart, coupons)
#   counter=0
#   while counter < coupons.length
#     cart_item = find_item_by_name_in_collection(coupons[counter][:item],cart)
#     couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
#     cart_item_with_coupon= find_item_by_name_in_collection(couponed_item_name,cart)
    
#     # pp cart_item
    
#     while cart_item && cart_item[:count]>= coupons[counter][:num]
#       if cart_item_with_coupon
#         cart_item_with_coupon[:count]+=coupons[counter][:num]
#         cart_item[:count] -= coupons[counter][:num]
#       else
#         cart_item_with_coupon = {
#           :item => couponed_item_name,
#           :price => coupons[counter][:cost]/coupons[counter][:num],
#           :clearance => cart_item[:clearance],
#           :count => coupons[counter][:num]
#         }
#         cart << cart_item_with_coupon
#         cart_item[:count] -= coupons[counter][:num]
#       end
#     end
#     counter+=1
#   end
  
#   return cart
# end


# # def apply_coupons(cart, coupons)
# #   a = “testing”
# #   puts a
# # end
# def apply_clearance(cart)
#   counter=0
#   while counter < cart.length
#     if cart[counter][:clearence]
#       cart[counter][:price]= (cart[counter][:price]- (cart[counter][:price]*0.20))
#     end
#     counter+=1
#   end
#   cart
# end
# def checkout(cart,coupons)
#   consi_cart= consolidate_cart(cart)
#   copo_cart = apply_coupons(consi_cart,coupons)
#   final_cart = apply_clearance(copo_cart)
#   total=0
#   i=0
#   while i < final_cart.length
#     total+=final_cart[i][:price] * final_cart[i][:count]
#     i+=1
#   end
#   if total > 100
#   total -= (total - 0.10)
# end
# total
# end