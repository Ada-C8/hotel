What classes does each implementation include? Are the lists the same?

Each implementation includes the following classes (They are the same):
CartEntry
ShoppingCart
Order


Write down a sentence to describe each class.

CartEntry: This class includes the quantity and price of each item in the ShoppingCart

ShoppingCart: This class includes an array of entries.

Order: This class calculates the total price of the order including sales tax.

** In implementation B the CartEntry calculates the cost of the entry and the ShoppingCart calculated the total (with sales tax being included in the order).  In implementation A the Order combines all the calculations for price. **


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

ShoppingCart holds an array that can be filled with instances of CartEntry (or anything else for that matter, since it isn't hard coded into the ShoppingCart class.) Order has-a ShoppingCart

What data does each class store? How (if at all) does this differ between the two implementations?

CartEntry: unit price and quantity of the item in the cart
ShoppingCart: collection of entries
Order: an instance of ShoppingCart, and the constant value of the SALES_TAX.

The data stored in each class is the same for both classes, the difference is that in implementation A the Order is responsible for all the pricing calculations whereas in Implementation B, each class has a method to communicate the calculation of the price.

What methods does each class have? How (if at all) does this differ between the two implementations?

A:
CartEntry: attr_accessor for unit price and quantity
ShoppingCart: attr_accessor for entries
Order: total_price to calculate the total price of the Order

B:
CartEntry: same as A with additional price method to calculate the price of the CartEntry
ShoppingCart: same as A with an additional price method to calculate the sum of all the CartEntry prices
Order: same, but the total_price method receives a method from the ShoppingCart to receive the total price before tax and the uses that to calculate the total_price with tax. This is a better implementation since the calculation done on the entries is done in their respective methods instead of in the Order class.

Consider the Order#total_price method. In each implementation:


Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?


Does total_price directly manipulate the instance variables of other classes?


If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

Which implementation better adheres to the single responsibility principle?

Implementation B better adheres to the single responsibility principle.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Implementation B is more loosely coupled.
