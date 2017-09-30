1. What classes does each implementation include? Are the lists the same?

Each of the implementations has three classes: CartEntry, ShoppingCart, and Order. The lists are the same.


2. Write down a sentence to describe each class.

CartEntry seems to be any item/purchase you want to put in your cart, and must have a unit price and quantity. A ShoppingCart holds zero or more CartEntries in an array. Orders have a Shopping Cart, and calculate the total price (including Sales Tax) of all of the Cart Entries in the Cart.

3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Orders have a ShoppingCart which can hold zero or more CartEntries.

4. What data does each class store? How (if at all) does this differ between the two implementations?

__A__
Cart Entry: @unit_price & @quantity instance variables
ShoppingCart: @entries array
Order: SALES_TAX constant, @cart variable that is an instance of ShoppingCart.

__B__
Cart Entry: @unit_price and  @quantity instance variables
ShoppingCart: @entries array
Order: Constant SALES_TAX, @cart variable that is an instance of  ShoppingCart


5. What methods does each class have? How (if at all) does this differ between the two implementations?

__A__
CartEntry: Initialize method, accessors for @unit_price and @quantity
ShoppingCart: Initialize method, accessor for @entries
Order: Initialize method, total_price method that calculates the sum of the prices of each entry in the @cart, and returns the total_price including SALEX_TAX.

__B__
CartEntry: Initialize method, price method that returns the price of each CartEntry
ShoppingCart: Initialize method, price method that returns the sum of the prices of each entry in the @cart.
Order: Initialize method, total_price method that returns the total price, including sales tax, of all of the items in the cart.


6. Consider the Order#total_price method. In each implementation:

  Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

  __A__
  The logic to compute the price is retained in Order.

  __B__
  The logic to compute the price is delegated to "lower level" classes like ShoppingCart and CartEntry.

  Does total_price directly manipulate the instance variables of other classes?

  __A__
  If I'm reading the question correctly, total_price directly manipulates instance variables of other classes in implementation A. It must access the entries array of the @cart instance, then iterate over each CartEntry instance to access the unit_price and quantity of each to calculate the price, sum up the prices of each CartEntry instance, then add the SALES_TAX to get the total_price.

  __B__
  No; Implementation B calls the .price method on the @cart, then adds the SALES_TAX to calculate the total_price.

7. If we decide items are cheaper if bought in bulk, how would this change the code?

We would have to add logic for the discounted bulk price (e.g. a lower unit_price or some kind of discount that is applied) if someone places a bulk order. We would also have to determine how a bulk order is placed, whether it's a subclass, or if we just add conditionals to our existing

8. Which implementation is easier to modify?

Implementation B- classes better follow single responsibility principle and logic is delegated to "low level" classes, and we can better target only the relevant classes and methods for modification without fear of messing up some other code.

9. Which implementation better adheres to the single responsibility principle?

Implementation B

10. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
