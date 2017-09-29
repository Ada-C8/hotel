#What classes does each implementation include? Are the lists the same?

Implementation A includes the following classes:
CartEntry, ShoppingCart, Order

Implementation B includes the following classes:
CartEntry, ShoppingCart, Order

The lists are the same.

#Write down a sentence to describe each class.

CartEntry adds an item to cart with the quantity and unit price.

ShoppingCart holds a list of all items added to the cart.

Order creates a new instance of ShoppingCart and can calculate the total price of the cart.


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

An Order holds a ShoppingCart and its price.  A ShoppingCart holds all items entered for that cart. A CartEntry is used to create entries that will be added to the ShoppingCart.

What data does each class store? How (if at all) does this differ between the two implementations?

In A and B, CartEntry stores the unit price and quantity for an item.

In A and B, ShoppingCart stores a list of entries.

In A and B, Order stores SALES_TAX and a ShoppingCart.

What methods does each class have? How (if at all) does this differ between the two implementations?

A has the following methods for each class:
CartEntry: initialize
ShoppingCart: initialize
Order: initialize, total_price

B had the following:
CartEntry: initialize, price
ShoppingCart: initialize, price
Order: initialize, total_price

B has a method to calculate price for each class, rather than only one as in A.


Consider the Order#total_price method. In each implementation:

Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In B the logic to compute price is contained in lower level classes, but in A it is not - in A it is retained in Order.

Does total_price directly manipulate the instance variables of other classes?

In A it does.

If we decide items are cheaper if bought in bulk, how would this change the code?

In A it would be harder to change because we do not calculate price for each item separately in A.

In B it would be easier to change, because we could add code to give an item discount when bought in bulk in the CartEntry class.  Since price is calculated for each item in CartEntry, the other classes would not be affected or have knowledge of this change.

 Which implementation is easier to modify?

 B is easier to modify.

Which implementation better adheres to the single responsibility principle?

B adheres better.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

B is more loosely coupled.
