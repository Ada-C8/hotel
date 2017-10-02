What classes does each implementation include? Are the lists the same?
A: CartEntry, ShoppingCart, Order
B: CartEntry, ShoppingCart, Order
(The same!)

Write down a sentence to describe each class.
CartEntry: In both implementations, it collects the unit price and quantity. B will also find the price by multiplying the two arguments passed in.
ShoppingCart: Both create an array of items in the cart. In B, I _think_ it is trying to iterate through the entries array and add the price of each item in the cart to sum (it is unclear where entry.price is coming from, but I assume from CartEntry.price?)
Order: Each implementation finds the total price of the order, including tax. A does it by iterating through the entries array and adding each item with its own tax to a total price, whereas B adds tax to the final subtotal.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
CartEntry collects info of an item placed in the cart > ShoppingCart stores each entry into an array > Order calculates the total cost of items in the array, plus tax.

What data does each class store? How (if at all) does this differ between the two implementations?
@unit_price, @quantity, @entries, @cart. They all seem the same to me--initialized the same and seem to hold the same information.

What methods does each class have? How (if at all) does this differ between the two implementations?
Each class has an initialize method. Both Order classes have a total_price method. implementation B has an additional price method for its CartEntry and ShoppingCart classes.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
implementation A does not--it retains all logic in itself, and only uses values from other classes. B does, using ShoppingCart#price.

Does total_price directly manipulate the instance variables of other classes?
No. They both use the values in local variables.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
I feel like A would be easier to modify because it calculates the price only once, and it would be simpler to make changes in one class than the several classes it would be in B.

Which implementation better adheres to the single responsibility principle?
A. A keeps all of its pricing math within the Order class, whereas B calculates price in some way in each of its classes.

Identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class.
My Reservation class should only be responsible for a single reservation. Instead of Reservation creating AND storing every instance, I should have a Hotel class to store all reservations in. That would make it much easier to create a Blocks class, which I was unable to do when the project was originally assigned.
