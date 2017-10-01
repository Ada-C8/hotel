What classes does each implementation include? Are the lists the same?

CartEntry, ShoppingCart, Order. They are the same.

Write down a sentence to describe each class.

CartEntry: creates object with unit_price and quantity in implementation A. B has price method defined inside the class.

ShoppingCart: Object has empty array. B also has method for price which sums the entry array.

Order: Adds up price of total order.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

They describe a product(CartEntry), group of products(ShoppingCart), and pricing data for a total order(Order).

What data does each class store? How (if at all) does this differ between the two implementations?

CartEntry: stores unit price and quantity. Imp B has method to return total value of combined units.

ShoppingCart: stores entries in an array. Imp B has method to return total price of an entry object.

Order: stores ShoppingCart objects, has method to calculate the total price of an order. Imp A has all logic contained inside the method, Imp B has it spread through classes.

What methods does each class have? How (if at all) does this differ between the two implementations?

Imp A classes only initialize objects except for the Order class, which has a method for getting total price.

Imp B classes all have price methods.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

Only in Imp A is it all retained in Order.

Does total_price directly manipulate the instance variables of other classes?

It doesn't change those variables.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

We would update total_price to include logic that says if a certain number of products are purchased, the prices temporarily change.

This would be easier to implement in Imp A, because all logic is contained in total_price.

Which implementation better adheres to the single responsibility principle?

Imp A

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Imp A
