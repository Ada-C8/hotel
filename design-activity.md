-What classes does each implementation include? Are the lists the same?
A: CartEntry, ShoppingCart, Order
B: CartEntry, ShoppingCart, Order
Yes they are the same classes, but they have different methods within them.

-Write down a sentence to describe each class.
CartEntry is all about initializing the product- figuring out how many products there are (quantity) and what their unit price is (unit_price). The difference between the two (A & B) is that in A, CartEntry grants full access (read and write) to those two variables whereas B does not. B also includes a method called Price that multiplies and returns those two integers together.

ShoppingCart is similar in both in that it collects the entries the customer wants by initializing an empty array that assumably will be filled up by a customer's order. Again, A allows reading and writing access whereas B does not. B also includes ANOTHER method called price. This method assumably sums the total of the entire shopping cart, based on the entries that are provided. This is a bit confusing in that there is already a price method created in the class above.

The last class in each is called Order. Order in both initializes the instance of the cart by creating a new instance of the ShoppingCart class. They each have a method called total_price. A references the instance variables entries from ShoppingCart and unit_price as well as quantity from CartEntry to calculate and return the total. But B only calls on the ShoppingCart class and it's price method. Again, I am not totally sure which price method it is trying to call on because there are two price methods and that is confusing for me.  

-How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
A: The Order class pulls from both of the prior classes (CartEntry and ShoppingCart). The first two classes do the prep work almost for the Order class to then execute the logic and put it all together. Essentially, the first two classes in A are initializing variables in preparation for the Order class.
B: Has a method in each class. In it's Order class, it is only calling on ShoppingCart and using the method from it's class (price). Not much is being done actually with the CartEntry class in B. Stuff gets initialized but then it appears as though it is never called on again. UNLESS the price method that is called in the ShoppingCart in the each loop is references the price method from the CartEntry. Then it is a dependency on the CartEntry class and things are connected. But again, I can't be sure.  

-What data does each class store? How (if at all) does this differ between the two implementations?
A: A stores the unit_price, quantity, entries, the constant sales_tax, an instance of the ShoppingCart, and the total_price (sum).
B: B stores the unit_price, quantity, the calculated price of those two variables multiplied together, the entries, the price of those added together, the constant sales_tax, an instance of the ShoppingCart, and the total_price (sum).
So essentially, B stores a whole lot more, not totally sure if all of it is necessary though.

-What methods does each class have? How (if at all) does this differ between the two implementations?
A: Beyond the initializing method in each class, A only has the total_price method.
B: Building off of the initialized methods in each class, B has two price methods (which is driving me crazy) as well as the total_price method.

-Consider the Order#total_price method. In each implementation:
  -Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
The logic is all done (retained) for A in the total_price method. BUT for B, the logic for what "price" is is done in the ShoppingCart class. Thus an unnecessary dependency is created.

  -Does total_price directly manipulate the instance variables of other classes?
For A, total_price simply calls the instance variables, but does not change them to do the calculation. B renames the cart's price "subtotal" and then returns the total_price.

-If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
I believe A is easier to modify so I would go with that implementation. I would change the code by adding bulk_discount logic if the quantity in CartEntry got over a particular number. I would do that in it's own class to stick with the Single Responsibility mantra.

-Which implementation better adheres to the single responsibility principle?
I believe A because it is easier to manipulate. Each class is doing just ONE thing. B is calculating price in each as well as initializing different data entries from the customer.

-Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
************ RESPONSE **********


HOTEL ACTIVITY:
-Identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class.

My Block class definitely needs to be reworked. I was not happy with it when I submitted it so I am ready to revisit it and try to tackle it's flaws. The logic for Block lived in too many places. The Reservations class contained methods that pertained to the Block class. I originally did this because the block would be modifying the reservations list and thus I thought it should go with the rest of the reservations.

Also, I tried my best to fix my naming conventions (taking the word array out of the variable names) and also tried to fix my check_availability method based on Jamie's feedback. **** Q for Jamie: Does that method look better now?

-Describe what changes you would need to make to improve this design, and how why the resulting design would be an improvement.

So I am trying my best to clean up my Block class to make single responsibility happen. I want that class to create a block and then reserve a room from it. I am trying to organize my methods and rewrite them so that the attributes are not modifying the attributes of another class, as it was doing previously. 
