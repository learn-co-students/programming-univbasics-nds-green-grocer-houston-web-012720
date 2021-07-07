def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  counter = 0
  item = nil
  while collection[counter] do
    if collection[counter][:item] == name
      item = collection[counter]
    end
    counter += 1
  end
  item
end

def return_position(item,collection)
  counter = 0
  while collection[counter] do
    if collection[counter][:item] == item
      return counter
    end
    counter += 1
  end
  
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  counter = 0
  new_cart = []
  new_item = {}
  while cart[counter] do
    if !(find_item_by_name_in_collection(cart[counter][:item],new_cart) == nil)
      new_cart[return_position(cart[counter][:item],new_cart)][:count] += 1
    else
      new_item = cart[counter]
      new_item[:count] = 1
      new_cart << new_item
    end
    counter += 1
  end
  new_cart
end

def test_consolidate
  mycart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "KALE", :price => 3.00, :clearance => false}
 ]
 pp mycart
 pp consolidate_cart(mycart)
end

def test_coupons
  cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 2},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
  ]
  coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]
  pp cart
  pp coupons
  pp apply_coupons(cart, coupons)
  
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0
  while cart[counter] do
    coupons_counter = 0
    
    while coupons[coupons_counter] do
      if cart[counter][:item] == coupons[coupons_counter][:item]
        if cart[counter][:count] >= coupons[coupons_counter][:num]
          cart[counter][:count] -= coupons[coupons_counter][:num]
          couponed_item = {
            :item => "#{cart[counter][:item]} W/COUPON",
            :price => coupons[coupons_counter][:cost] / coupons[coupons_counter][:num],
            :clearance => cart[counter][:clearance],
            :count => coupons[coupons_counter][:num]
          }
          cart << couponed_item
          coupons.delete_at(coupons_counter)
          coupons_counter -= 1
          # if cart[counter][:count] == 0
          #  cart.delete_at(counter)
          # end
          
        end
      end
      coupons_counter += 1
    end
    counter += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0
  while cart[counter] do
    if cart[counter][:clearance] == true
      cart[counter][:price] = (cart[counter][:price]*0.8).round(2)
    end
    counter += 1
  end
  cart
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
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  counter = 0
  subtotal = 0
  while cart[counter] do
    subtotal += cart[counter][:price] * cart[counter][:count]
    counter += 1
  end
  if subtotal > 100
    subtotal *= 0.9
  end
  subtotal
end
