require 'pry'
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  result = {}
  index = 0 
  while index < collection.count do 
    item_name = collection[index]
    # see if name exist if so it returns the hash with the collection of array
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
    
    # see if item is in the new cart 
    cart_item = find_item_by_name_in_collection(item_name[:item],new_cart)
    
    # checks if the item is in the new cart and increases it 
    if cart_item != nil 
      cart_item[:count] += 1
      
      # creates an item for the new cart 
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
  
  coupon = coupons[index]
  
  # see if the item exist already in the cart
  cart_item = find_item_by_name_in_collection(coupon[:item], cart) 

   item_coupon = coupon[:item]
  
    #see if the item with coupon already exist in the car
    coupon_item = "#{coupon[:item]} W/COUPON"
  
    coupon_with_item = find_item_by_name_in_collection(coupon_item, cart)
    
   
    
   # see if there's an item and see if the item has the require amount to apply the coupon
    if cart_item && cart_item[:count] >= coupon[:num]
  
    
      # see if the item with coupon exist and increases the # of items on the applied coupon
      #once coupon is applied subtract the original cart of the # item the coupon has been applied to
    if coupon_with_item
        coupon_with_item[:count] += coupon[:num]
        cart_item[:count] -= coupon[:num]
     
        
        # creates cart item with coupons
      else
        
        cart_item[:count] -= coupon[:num]
        new_item = {
          :item => coupon_item,
          :price => coupon[:cost] / coupon[:num],
          :count => coupon[:num],
          :clearance => cart_item[:clearance]
        }
        cart << new_item
       
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
  index = 0  
  while index < cart.count do 
    
    if cart[index][:clearance]
      
      cart[index][:price] = (cart[index][:price] - (cart[index][:price] * 0.2)).round(2)
    end
    index +=1 

  end
  cart
  #
  #binding.pry
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
  consolidate_cart = consolidate_cart(cart)
  coupon_apply_cart = apply_coupons(consolidate_cart, coupons)
  clearance_cart = apply_clearance(coupon_apply_cart)
  
  index = 0 
  total = 0
  while index < clearance_cart.count do 

    total += clearance_cart[index][:price] * clearance_cart[index][:count]
    #binding.pry
    index += 1 
  end
  if total > 100
    total -= total * 0.10
  end
  total
#binding.pry
end
