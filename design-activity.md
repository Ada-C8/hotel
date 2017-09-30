**What classes does each implementation include? Are the lists the same?**

**Implementation A** includes: CartEntry, ShoppingCart, and Order
**Implementation B**  includes: CartEntry, ShoppingCart, and Order

The two lists are the same, but the implementations are different. The first implementation has a master class that reaches inside of other classes to manipulate their instance variables; the second implementation has each method manipulate its own instance variables, and that information is passed on to other classes without being manipulated by them.  


**Write down a sentence to describe each class.**
Implementation A:
  **CartEntry** has an initialize method with two instance variables: @unit_price and @quantity
  **ShoppingCart** has one method, initialize, which has one instance variable, an array @entries that holds all of the CartEntries.
  **Order** has a constant, SALES_TAX, and two instance methods: initialize, and total_price; it initializes with @cart, which creates an instance of ShoppingCart; total_price sums all of the of the prices of the items in the cart, which is initialized within the class. It does this by iterating over entries from the cart and summing their totals.

Implementation B:
  **CartEntry** Includes an initialize function which initializes with @unit_price and @quanity, like the first implementation; however, it also includes a price method, which returns the price of each item by multiplying the two variables together.
  **ShoppingCart** Initializes with @entries; also returns the price of the entire cart by iterating over entries and returning a sum of their prices.
  **Order** Has an initialize function with @cart, which creates a new instance of ShoppingCart; the total_price method in this class's implementation of that method calls cart.price and then multiplies by the SALES_TAX constant.


	**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**
  **A:** An Order has a ShoppingCart; a ShoppingCart has a CartEntry. An order creates a total_price by reaching into the cart and manipulating its data.

  **B:** An Order has a ShoppingCart; a ShoppingCart has a CartEntry. Each class has price, and each successive layer builds on the price to be specific to its class. I.e., an item has a price calculated using its variables; a shopping cart has a price, calculated by adding up the prices of each item in the cart (already accessible because it was calculated by the CartEntry class); Order's total_price expands on this by adding tax to the ShoppingCart price.**

	**What data does each class store? How (if at all) does this differ between the two implementations?**
    **CartEntry**  Stores @unit_price and @quantity for each item.
    **ShoppingCart** Stores @entries, which are instances of CartEntry
    **Order** Stores a @cart which is just an instance of a cart.

    The data itself is the same across the two implementations; the way the data is manipulated is what differs between them.


	**What methods does each class have? How (if at all) does this differ between the two implementations?**
  **Consider the Order#total_price method. In each implementation:**
	**Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**

     **Does total_price directly manipulate the instance variables of other classes?**

    In the first implementation, each class has an initialize function which initializes only with the data described above. Only the Order method has an additional method, which is price.

    In the second implementation, each of the three classes has the same initialize method as in the first, but each also contains a price method.

    The methods differ between the two implementations significantly. In the first, all of the business logic is contained in the Order class, which reaches into the CartEntry class to manipulate @unit_price and @quantity to get a price. In the second implementation, each class has a method that calculates a price without having to use other classes instance variables. The logic for each class is carried out within its method.



  **If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**
    In the first implementation, this is really difficult. Because all of the price logic is lumped into one big method, it's hard to single out items.
    We'd have to make a method within the Order class to figure out how many of a particular item are in a cart to then apply a discount to the price (which is in another class altogether).

    In the second implementation, we'd could just modify the CartEntry class to accept a quantity for an entry, and then we could apply a discount if that quantity meets a certain criteria. It could adjust the price within the entry method, and the other classes would never have to worry about it. It wouldn't affect the logic of the total_price method in this case because it's dealt with before the Order class ever sees it.



	**Which implementation better adheres to the single responsibility principle?**
    implementation B.


  Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
