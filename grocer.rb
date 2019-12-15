require 'pry'
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  result = {}
  index = 0 
  while index < collection.count do 
    item_name = collection[index]
  if name === item_name[:item] 
   result = item_name
   return result 
  end
  index +=1
end
  
nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = [ ]
  index = 0 
  while index < cart.count do 
    item_name = cart[index]
    cart_item = find_item_by_name_in_collection(item_name[:item],new_cart)
    if cart_item != nil 
      cart_item[:count] += 1
    else
      cart_item = cart[index]
      cart_item[:count] =  1
      new_cart << cart_item
    end

    index += 1
  
end
new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  
  while index < coupons.count do 
    item_name = coupons[index]
 
  cart_item = find_item_by_name_in_collection(item_name[:item],cart)

    coupon_item = "#{item_name[:item]} W/COUPON"
    
    coupon_to_apply_item = find_item_by_name_in_collection(coupon_item, cart)
    
    if cart_item && cart_item[:count] >= item_name[:num]
      if coupon_to_apply_item
        coupon_to_apply_item[:count] += item_name[:num]
        cart_item[:count] -=item_name[:num]
      else
        coupon_to_apply_item = coupons[index]
        cart << coupon_to_apply_item
        cart_item[:count] -= item_name[:num]
      end
       
      end
       index += 1
  end

  cart

end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
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
end
