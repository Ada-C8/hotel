- What classes does each implementation include? Are the lists the same?

  Each implementation includes the same three classes consisting of CartEntry, ShoppingCart, and Order.

- Write down a sentence to describe each class.

  CartEntry: Initializes unit_price and quantity (implementation A & B), and calculates the price of the entry to be added to the cart (implementation B).

  ShoppingCart: In both implementations, an entries array is initialized, however, the only difference is that implementation B has a price method that returns the sum of each entry utilizing the price method from the CartEntry class.

  Order: Each of the order classes initializes a new instance of the ShoppingCart class and returns the total price of the shopping cart after factoring in tax.

- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

  Each class relies on attributes of the class prior. for example, in implementation B, the ShoppingCart class entries array will consist of the instances of the car class after the price method has been executed and the Order class returns the total price based on what is returned in the ShoppingCart class.


- What data does each class store? How (if at all) does this differ between the two implementations?

  Implementation A
    CartEntry: Stores a unit_price and quantity instance variables.

    ShoppingCart: Stores an entires array.

    Order: Stores an instance of the ShoppingCart class and a method that sums the total of the entires array and adds tax.

  Implementation B
    CartEntry: Stores a unit_price and quantity instance variables and a price method that returns the sum of the unit_price and quantity multiplied.

    ShoppingCart: Stores an entires array and has a price method that returns the sum of all the entries in the array

    Order: Stores an instance of the ShoppingCart class and has a total_price method that adds tax to the sum of entries array.


- What methods does each class have? How (if at all) does this differ between the two implementations?

    Implementation A (methods in each class)
      CartEntry: No methods
      ShoppingCart: No methods
      Order: total_price

    Implementation B (methods in each class)
      CartEntry: price
      ShoppingCart: price
      Order: total_price

- Consider the Order#total_price method. In each implementation:
  - Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order

    In implementation B, logic to compute total_price is broken down throughout the three classes whereas in implementation A all of the logic to compute total price resides in the order class.

  - Does total_price directly manipulate the instance variables of other classes?

    No, the total_price method does not directly manipulate the instance variables of the other classes.


- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

  If items are bought in bulk, it would be easier to update the code in Implementation B, specifically within the CartEntry class as it deals with a quantity instance variable. The update can be done by adding a conditional.


- Which implementation better adheres to the single responsibility principle?

    Implementation B better adheres to the single reason principle.

<!-- - Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled? -->
