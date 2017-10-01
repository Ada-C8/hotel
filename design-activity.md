
What classes does each implementation include? Are the lists the same?

Both implementations create the same Classes, CartEntry, ShoppingCart, and Order, but they are not the same in terms of how they work.

Write down a sentence to describe each class.

For implementation A:
  CartEntry creates a CartEntry Object with a unit_price and a quantity that can be read and written to.

  ShoppingCart creates a ShoppingCart Object with an entries array

  Order creates an Order object that contains an instance of the ShoppingCart class, which is assigned to an @cart instance variable, as well as establishing a sales tax constant and a total_price method.

For implementation B: 



How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

es a sales tax constant. It contains a total_price method, which goes through the cart entries, find their unit_price and quantity, sums each of these, and then returns the total price plus the SaleTax on that price. There doesn't seem to be a method that would actually put the cart entries into the cart.

What data does each class store? How (if at all) does this differ between the two implementations?
What methods does each class have? How (if at all) does this differ between the two implementations?
Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Which implementation better adheres to the single responsibility principle?
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
