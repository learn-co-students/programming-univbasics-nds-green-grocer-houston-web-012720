# test data sets
cart1 = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "KALE", :price => 2.00, :clearance => false},
  {:item => "AVOCADO", :price => 3.00, :clearance => true},
  {:item => "SALAD", :price => 4.00, :clearance => false}
]

coupons1 = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "SALAD", :num => 1, :cost => 2.50},
  {:item => "KALE", :num => 3, :cost => 5.00}
]

def find_item_by_name_in_collection(name, collection)
  index = 0
  while index < collection.length do
    if collection[index][:item] == name
      return collection[index]
    else index += 1
    end
  end
end

def add_count_to_item(item_info)
  {
    :item => item_info[:item],
    :price => item_info[:price],
    :clearance => item_info[:clearance],
    :count => 1
  }
end

def consolidate_cart(cart)
  cart_consolidated = [add_count_to_item(cart[0])]
  i = 1
  while i < cart.length do
    k = 0
    old_item = cart[i]
    # Doesn't work
    # if cart[i][:item] == cart_consolidated[k][:item]
    #   cart_consolidated[k][:count] += 1
    # elsif cart_consolidated[k] = nil || cart_consolidated[k+1] = nil
    #   cart_consolidated << add_count_to_item(cart[i])
    # else
    #   k += 1
    # end
    if find_item_by_name_in_collection(old_item[:item],cart_consolidated)
      find_item_by_name_in_collection(old_item[:item],cart_consolidated)[:count] += 1
    else
      cart_consolidated << add_count_to_item(old_item)
    end
    i += 1
  end
  if cart[0] != nil
    cart_consolidated
  else
    print "Your cart is empty!"
  end
end
# consolidate_cart(cart1)

def apply_coupons(cart, coupons)
  i = 0
  if coupons[0] == nil
    cart
  else
    while i < coupons.length do
      couponed_item = find_item_by_name_in_collection(coupons[i][:item], cart)
      if couponed_item[:count] >= coupons[i][:num]
        # if couponed_item[:count] - coupons[i][:num] == 0
        #   couponed_item[:item] = "#{couponed_item[:item]} W/COUPON"
        #   couponed_item[:price] = coupons[i][:cost]
        # else
          couponed_item[:count] -= coupons[i][:num]
          item_w_coupon_applied = {
            :item => "#{coupons[i][:item]} W/COUPON",
            :price => coupons[i][:cost]/coupons[i][:num],
            :clearance => couponed_item[:clearance],
            :count => coupons[i][:num]
          }
          cart << item_w_coupon_applied
        # end
      else
        nil
      end
      i += 1
    end
    cart
  end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end
# cart2 = consolidate_cart(cart1)
# apply_coupons(cart2, coupons1)

def apply_clearance(cart)
  i = 0
  while i < cart.length do
    cart[i][:clearance] == true ? cart[i][:price] = (cart[i][:price]*0.8).round(2) : nil
    i += 1
  end
  cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def subtotal(cart)
  subt = 0
  i = 0
  while i < cart.length do
    subt += (cart[i][:price] * cart[i][:count])
    i += 1
  end
  subt
end

def bulk_discount(total)
  total >= 100? total = (total*0.9).round(2) : total
end


def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(new_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  final_subtotal = subtotal(clearanced_cart)
  grand_total = bulk_discount(final_subtotal)


  clearanced_cart
  grand_total

  # Consult README for inputs and outputs
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
checkout(cart1, coupons1)
