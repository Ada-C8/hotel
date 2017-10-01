
What classes does each implementation include? Are the lists the same?

  Both implementations create the same Classes: CartEntry, ShoppingCart, and Order, but they are not the same in terms of how they work.

Write down a sentence to describe each class.

For implementation A:
  CartEntry creates a CartEntry Object with unit_price and quantity instance variables that can be read and written to.

  ShoppingCart creates a ShoppingCart Object with an entries array.

  Order creates an Order object that contains an instance of the ShoppingCart class, which is assigned to an cart instance variable, as well as establishing a sales tax constant and a total_price method.

For implementation B:

  CartEntry creates a CartEntry Object with unit_price and quantity instance variable, and a method that returns a total price based on those variables.

  ShoppingCart create a ShoppingCart Object with an entries array, as well as a method for determining the total pre-tax price of the entries in the cart.

  Order creates an Order object that contains an instance of the ShoppingCart class, which is assigned to a cart instance variable, as well as establishing a sales tax constant and a total_price method.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

-- For both implementations, I am assuming that there is a method somewhere else that allows you to add CartEntries to a ShoppingCart.

Implementation A:

  Each object of the Order Class contains an instance of the ShoppingCart class, which contains CartEntries, which each have a price and quantity attached. The Order Class uses the unit_price, quantity, and SalesTax constant to determine a total order price.

Implementation B:

  Each object of the Order Class contains an instance of the ShoppingCart class, which contains CartEntries. The price of each CartEntry is determined by the CartEntry class, using the unit_price and quantity for each entry. These prices are summed by the ShoppingCart class, to get a total price for the cart. The Order class then applies the appropriate tax to each order based on the ShoppingCart Price and the Tax Constant.


What data does each class store? How (if at all) does this differ between the two implementations?
What methods does each class have? How (if at all) does this differ between the two implementations?

Implementation A:

  CartEntry stores unit_price and quantity, and has accessor methods for each of these.
  ShoppingCart stores an array entries, and has an accessor method for those entries.
  Order stores a SalesTax Constant and instances of the ShoppingCart class. It has a method for determining a total price including tax.  


Implementation B:

  CartEntry stores unit_price and quantity, but, unlike Implementation A, there is no accessor method for either variable. There is a price method that uses the variables to determine a price, and allow other methods to read this amount.

  ShoppingCart stores an array entries, but, unlike Implementation A, there is no accessor method for  those entries. There is a method that uses the CartEntry prices, as determined by the CartEntry class's price method, to determine a total price for the cart, which can be accessed by the Order Class.

  Order stores a SalesTax Constant and instances of the ShoppingCart class. It has a method for determining a total price by applying sales tax to the cart price determined by the ShoppingCart Class's price method.   


Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

For Implementation A, the logic is contained in the Order Class. For Implementation B, is spread out among all three classes.

Does total_price directly manipulate the instance variables of other classes?

For Implementation A, the Order Class manipulates the CartEntry Instance Variables, as well as the ShoppingCart entries. For Implementation B, the Classes don't manipulate Instance Variables of other classes, but make use of calculations made in those classes.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

This would be easier in Implementation B, because you could add a method to the CartEntry that would apply the necessary discount, which would then be passed along as part of the price. Whereas in Implementation A, you would have to try to put this into the Order Class.

Which implementation better adheres to the single responsibility principle?

Implementation B.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Implementation B
