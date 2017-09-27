1. What classes does each implementation include? Are the lists the same?

Both implementation A  and implementation B include the following classes: CartEntry, ShoppingCart, and Order.

2. Write down a sentence to describe each class.

CartEntry is responsible for housing and determining information about an item in the cart. Since the price of a CartEntry relies on CartEntry's unit_price and quantity instance variables, it should be wrapped in an instance method in the CartEntry class (which implementation B does).

The ShoppingCart is responsible for managing a set of cart entries. Since the price of all the entries relies on the entries instance variable, the sum price of all the entries can be placed in an instance method in ShoppingCart (as implementation B does).

The Order class is responsible for managing order information for a ShoppingCart. In implementation B, the Order class can calculate the total_price by relying solely on its instance variable cart.

3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

The CartEntry class creates entries. The ShoppingCart houses and manages instances of ClassEntry. Each instance of the Order class contains an instance of ShoppingCart.

4. What data does each class store? How (if at all) does this differ between the two implementations?

CartEntry stories unit_price and quantity. ShoppingCart stores entries. Order stores a cart. Implementation A has attr_accessors for unit_price, quantity, and entries, which allows you to access these data in other classes. Implementation B separates the data more by isolating the code that reads or modifies these variables in the classes where the variables are stored.

5. What methods does each class have? How (if at all) does this differ between the two implementations?

In implementation A, each class has an initialize method and Order has a total_price method. Implementation B has these methods as well as price methods in ShoppingCart and CartEntry.

6. Consider the Order#total_price method. In each implementation:

* Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

  * In implementation A, the logic to compute price is solely retained in Order. However, in implementation B, the logic to compute price is delegated according to the variables that it uses. For example, CartEntry can compute the price for a single entry using unit_price and quantity, while ShoppingCart can determine the price of all the entries stored in the entries instance variable. Now, order doesn't need to use the attr_accessors, it can now just rely on its own instance of cart to determine the total_price.


* Does total_price directly manipulate the instance variables of other classes?

  * In implementation A, total_price accesses and reads the instance variables of other classes, such as unit_price, quantity, and entries. However, in implementation B, total_price doesn't rely on any attr_accessors to access these instance variables.


9. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

Implementation B is easier to modify because it isolates the logic to compute the price for an entry to the CartEntry class. In implementation B you would change the code in CartEntry's price method to account for how the price changes based on the quantity.


10. Which implementation better adheres to the single responsibility principle?

Implementation B better adheres to the single responsibility principle because it better isolates the price behavior and logic to lower level classes.

11. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Implementation B is more loosely coupled. It better isolates external messages to other classes. For example, in implementation A, Order#total_price relies on .entries in ShoppingCart and .unit_price and .quantity in CartEntry. However, in implementation B, Order#total_price only relies on one external message to ShoppingCart's price method.
