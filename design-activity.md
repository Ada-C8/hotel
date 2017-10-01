<!-- design-activity.md -->

What classes does each implementation include? Are the lists the same?
  Both implementations use these classes: CartEntry, ShoppingCart, Order.

Write down a sentence to describe each class.
  Implementation A:
  CartEntry - stores the unit price and quantity for an item
  ShoppingCart - stores an array of CartEntry objects
  Order - creates a new ShoppingCart object and calculates the total cost, including tax, of the items in the ShoppingCart.

Implementation B:
  CartEntry - stores the unit price and quantity for an item (same as A)
  ShoppingCart - stores an array of CartEntry objects and calculates the total cost of the items, independent of sales tax.
  Order - creates a new ShoppingCart object and calculates the total cost of the items in the Shopping Cart by calling the ShoppingCart.price method and applying a sales tax.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  See attached photo called "shopping_cart_diagram.JPG" (photo of doodle diagram).

What data does each class store? How (if at all) does this differ between the two implementations?
  CartEntry- stores unit_price and quantity data for each CartEntry object.
  ShoppingCart- stores array of entries objects.
  Order- stores cart object but no data.

What methods does each class have? How (if at all) does this differ between the two implementations?
  Implementation A includes initialize methods for all three classes; only the Order class has an additional method, which calculates the total price of an order. Implementation B differs in that all classes have an additional method that calculates price.

Consider the Order#total_price method. In each implementation:
  Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    In Implementation A, the logic to compute price is retained by the Order class. In Implementation B, it is delegated to the ShoppingCart class and the Order class.

  Does total_price directly manipulate the instance variables of other classes?
    In Implementation A, total_pice manipulates instance variables of other classes, but Implementation B does not.

  If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    Implementation B would be easier to modify because the user can do a cost comparison of the price of the item at the item level, since there is a price method in the CartEntry class. If bulk ordering is being considered, it might help to add another class that stores the bulk ordering requirements for a specific item. For example, there may be different prices for an item that is ordered in quantities of 1-25 vs. 26-100.

  Which implementation better adheres to the single responsibility principle?
    Implementation B.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  Implementation B.


Notes on Changes I've made to Hotel:
-created new names that make more sense if the future data structure changes: i.e. "array_of_rooms" was changed to "rooms", and "array_of_reservations" was changed to "reservations." etc.
-changed MyHotel class to be called simply Hotel
-in Block class, removed :check-in-date and :check-out attr_readers as they were not being used/referenced
-moved "find_reservations_by_date" method from Hotel class to Reservations class. Per Chris' suggestion, changed method to first calculate the date outside of the loop that generates the available rooms. changed corresponding tests.
