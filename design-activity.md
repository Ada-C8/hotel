1) What classes does each implementation include? Are the lists the same?
A includes CartEntry, ShoppingCart, and Order. B includes the same list of classes.

2) Write down a sentence to describe each class.
CartEntry represents individual items in a cart that have their own unit prices. The ShoppingCart represents an object that can hold 0, one, or many CartEntry instances. Order creates a new ShoppingCart and can calculate the total price of all CartEntry instances in a ShoppingCart instance.

3) How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
An Order instance has-a ShoppingCart instance, and ShoppingCart has-many CartEntry instances.

4) What data does each class store? How (if at all) does this differ between the two implementations?
A: CartEntry stores unit_price and quantity. ShoppingCart stores its list of CartEntry instances. Order stores a constant for sales tax, an instance of ShoppingCart, and the logic to calculate a total price, which includes direct references to both the ShoppingCart and CartEntry instance methods.

B: CartEntry additionally stores information on how to calculate its own price based on its unit_price and quantity. ShoppingCart additionally stores information on how to calculate its own price based on the prices of its entries. Order's total_price instance method has been simplified to only contain references to a sales tax constant and the ShoppingCart's price instance method.

5) What methods does each class have? How (if at all) does this differ between the two implementations?
The first method forces Order to know all the logic of calculating the price of the items in the ShoppingCart and adding the sales tax, while CartEntry and ShoppingCart only have accessor methods for their instance variables.

The second method makes CartEntry and ShoppingCart each responsible for calculating their own price, so Order just needs to call the ShoppingCart instance's price and calculate sales tax.

6) Consider the Order#total_price method. In each implementation:
  a) Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  A: Order#total_price is responsible for all logic in calculating the price of the cart including sales tax.
  B: Order#total_price only has to know to call the ShoppingCart instance's price method and add sales tax. ShoppingCart and CartEntry are responsible for some of the logic to compute the price.

  b) Does total_price directly manipulate the instance variables of other classes?
  A: Yes
  B: No

7) If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Implementation B - we could add that logic to the CartEntry#price method.

8) Which implementation better adheres to the single responsibility principle?
Implementation B - it separates the responsibilities for knowing about the instance variables to within the variable's class.

9) Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B.
