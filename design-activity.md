<!-- What classes does each implementation include? Are the lists the same? -->
Both implementations include the following three classes - CartEntry, ShoppingCart, and Order

<!-- Write down a sentence to describe each class. -->
The CartEntry class holds information on price and quantity for a given entry into a shopping cart.
ShoppingCart - is a collection of CartEntry objects.
Order - Responsible for the shopping cart and the total price of the cart.

<!-- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper. -->

The order class is the biggest class and draws upon the shopping cart class which in turn is in itself a collection of CartEntries. 

<!-- What data does each class store? How (if at all) does this differ between the two implementations? -->
CartEntry: Stores the unit price and the quantity of each CartEntry object.
ShoppingCart: Stores a collection of CartEntry object in an array.
Order: Stores a ShoppingCart object.

<!-- What methods does each class have? How (if at all) does this differ between the two implementations? -->
CartEntry:
  Implementation A - No methods.
  Implementation B - A price method to calculate and return the price of the CartEntry.

ShoppingCart:
  Implementation A - No methods.
  Implementation B - Has a price method that looks at each entry in the shopping cart, calls the CartEntry price method, and updates the variable sum, then returns the sum variable.

Order:
  Both implementations Order class have a total_price method. They each use the same structure to calculate and add sales tax but they ways they go about calculating the total price of the cart are they are quite different.

  Implementation A - table the total_price method loops through each entry in the cart (CartEntry), calculates the price per entry, updates the sum variable with each entries price. Then the sales tax is calculates and added to the sum and the total_price is returned.

  Implementation B - the Order class total_price method calls the price method built into the ShoppingCart class on the instance of the ShoppingCart object and stores the price into a variable. Then the sales tax is calculates and added to the sum and the total_price is returned.

  Implementation A's total_price method is self contained while the total_price method in implementation B is dependent on the price method in each of the other classes.

<!-- Consider the Order#total_price method. In each implementation: -->
  <!-- Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order? -->
  In implementation A the total_price method  logic is relatively self contained or retained while in Imp B the logic is delegated to both Shopping Cart and CartEntry classes by stringing their price methods together.

  <!-- Does total_price directly manipulate the instance variables of other classes? -->
  In implementation A the total_price directly manipulate the instance variables of the CartEntry instances while implementation B just calls the classes method on the instance of the class object.

<!-- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify? -->
Implementation B would be easier to change because you could add some logic into the CartEntry class so that when a certain quantity is reached you discount the price. In order to do that in Implementation A you would have to add logic to the Orders class which is messy and would be out of place.

<!-- Which implementation better adheres to the single responsibility principle? -->
Implementation B
<!-- Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled? -->
