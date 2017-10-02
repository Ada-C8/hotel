* What classes does each implementation include? Are the lists the same?

  a. Both implementation A and implementation B have three classes: CartEntry, ShoppingCart, and Order.

* Write down a sentence to describe each class.

  a. CartEntry class - In both implementations, this class initializes two instance variable unit price and quantity. In implementation B the CartEntry class also contains a price method that calculates price by multiplying unit price and quantity.

  b. ShoppingCart class- In implementation A, ShoppingCart is simply a collection of entries. In implementation B, ShoppingCart is a collection of entries and calculates the price for each entry.

  c. Order class - Order creates a new instance of `@cart`, sets a constant variable for sales tax, and calculates the total price of the cart. Implementation A calculates the entry total and multiplies it by the sales tax while implementation B simply sets the subtotal to `@cart.price` and multiplies the sales tax.  


* How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

  a. It seems that Order knows about ShoppingCart and ShoppingCart should know about CartEntry (this is assuming that each CartEntry gets pushed on to the `@entries` variable).

* What data does each class store? How (if at all) does this differ between the two implementations?

  a. CartEntry stores `@unit_price` and `@quantity`, ShoppingCart stores `@entries`,  Order stores `@cart` and `SALES_TAX`. The data is the same across both implementations.

* What methods does each class have? How (if at all) does this differ between the two implementations?

  a. Both implementations have a total_price method but implementation B also has two price methods. In implementation B, a price in calculated for each cart entry, the shopping cart, and the entire order. In implementation A, price is only calculated once in the Order class.

* Consider the Order#total_price method. In each implementation:
  * Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

    a. implementation A - logic to compute price is all retained in the Order class.
    b. implementation B - logic to compute price is delegated to the "lower level" classes, ShoppingCart and CartEntry.

  * Does total_price directly manipulate the instance variables of other classes?
    a. implementation A - Yes
    b. implementation B - No

* If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

  a. To make this modification, you would have to add a bulk discount to the method that calculates price. Implementation B is easier to modify because you can add the bulk discount to the CartEntry price method.

* Which implementation better adheres to the single responsibility principle?

  a. Implementation B

* Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

  a. Implementation B


# Revisiting Hotel

Describe in `design-activity.md` what changes you would need to make to improve this design, and how why the resulting design would be an improvement.

  * In the DateRange class, I was calculating number_of_nights in using aq instance variable and making use of that instance variable in the Reservation Class to return the price in the total_price method. The change I made here was change number_of_nights from an instance variable to a instance method and I called on that instance method in the total_price method in the Reservation class.

  * In the view_available_rooms method in the Hotel class, I got rid of the available_room_nums instance variable and made available_rooms a local variable that references the instance variable rooms. This helped to get rid of some redundancy and dry up my code. With this change, I was also able to reference the view_available_rooms method inside of the reserve_room method. I also removed the reserved_room_nums instance variable and made reserved_rooms into a local variable to dry up the code.
