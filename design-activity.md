What classes does each implementation include? Are the lists the same?
Implementation A: CartEntry, ShoppingCart, Order
Implementation B: CartEntry, ShoppingCart, Order
Yes, the lists are the same.

Write down a sentence to describe each class.
CartEntry: Creates instance of a single product at a single price, of however many quantities (eg 5 Honeycrisp apples at .49/each, NOT 2 granny smith apples and 3 gala apples.)
ShoppingCart: Holds all of the different items (CartEntries) as an array.
Order: Calculates the total price of all the entries in your shopping cart.


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
An Order has a ShoppingCart, and a ShoppingCart has a CartEntry.  

What data does each class store? How (if at all) does this differ between the two implementations?
In both implementations, CartEntry stores its unit price & quantity.  Again in both, ShoppingCart stores entries in a collection.  In both implementations, Order stores sales tax rate as a constant, but otherwise does not store data - Order just calls a new instance of ShoppingCart, and utilizes ShoppingCart and CartEntry's methods.

What methods does each class have? How (if at all) does this differ between the two implementations?
CartEntry initializes with a unit price and a quantity.  In implementation B, CartEntry has a method to calculate total price for that entry.  ShoppingCart initializes with an instance variable that stores entries as a collection.  In implementation B, ShoppingCart also has a method to calculate total price of the shopping cart entries, relying on the price method in the CartEntry class.  In both implementations, Order initializes by creating a new instance of ShoppingCart.  Both implementations also have a total_price method, but in implementation B, the method relies on the price method of the ShoppingCart class, whereas in implementation A, the method iterates through the items in the cart using the unit_price and quantity instance variables in the CartEntry class.


Consider the Order#total_price method. In each implementation:
Is logical to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
It is much more logical to compute the price in the "lower level" classes, as it does in Implementation B.  In implementation A, the price computing logic is contained in the Order class, which gives it too much responsibility & makes the Order class overly complicated.  Im implementation A, it would be a challenge to change elements related to price (coupons for certain items, quantity discounts).

Does total_price directly manipulate the instance variables of other classes?
No, in both implementations, total_price calls instance variables from CartEntry and ShoppingCart classes, but does not directly change those instance variables.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
There would need to be an addition of a conditional that states if quantity is at or higher than a given threshold, price is decreased by a given percentage.  This would be much easier and more easily understood in implementation B, where you would change the price method in CartEntry class to add this conditional, rather than in implementation A where it would all need to happen in the total_price method of the Order class, giving a lot of responsibility to that method.

Which implementation better adheres to the single responsibility principle?
Implementation B better adheres to single-responsibility, because the logic is delegated to each class, rather than all happening at the highest Order level.


Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
