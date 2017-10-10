Prompts

1. What classes does each implementation include? Are the lists the same?

    Implementation A - CartEntry, ShoppingCart, Order

    Implementation B - CartEntry, ShoppingCart, Order

    Yes, they look to be the same, the differences look to be in the methods.

2. Write down a sentence to describe each class.
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

    Implementation A - To calculate the price of the Order, the Order class has to access the instance variables of CartEntry and ShoppingCart in order to calculate the total_price.  

    Implementation B - In this case it is the ShoppingCart class which calls the price method of CartEntry in order to calculate the price of all instances (@entries) of CartEntry.  From there the Order class calls the price method from the ShoppingCart class to calculate the total of everything that is located in @cart.

    All in all Implementation B is much more sensical, especially seeing them side-by-side.

4. What data does each class store? How (if at all) does this differ between the two implementations?

    Each class stores the same data in both implementations.  

    CartEntry stores data for quantity and unit price of each instance of CartEntry in the ShoppingCart class.

    ShoppingCart contains all of these instances in an array.

    Order contains a constant variable.  This is set equal to the sales tax, as well as, an instance of ShoppingCart.

5. What methods does each class have? How (if at all) does this differ between the two implementations?

    The methods between the two implementations do differ, as such;  

    Implementation A - The classes CartEntry and ShoppingCart have only initialize methods.  There is one main method with all of the logic placed in the Order class.  This method essentially does the order pricing calculations and does so by directly accessing/using the instance variables located in ShoppingCart and CartEntry.  

    Implementation B - The classes have changed here with CartEntry and ShoppingCart now containing their own price methods with logic that allows for them to calculate the total price of the Order class.

    CartEntry's calculation method calculates the cost of an instance of CartEntry.  ShoppingCart's method calculates the total cost of all instances of CartEntry via @entries, which it does by calling the price method of CartEntry from within the class of ShoppingCart.  The addition of the Order class having a total_price method that adds in tax to the sum by calling on the price method in ShoppingCart.

6. Consider the Order#total_price method. In each implementation:

Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

    Implementation A - Logic is in the Order class, with the total_price method directly reading the instance variables of the ShoppingCart and CartEntry which then provides a calculation via the total_price method.

    Implementation B - There is a change in logic, which is now in the 'lower level classes'.  In order to calculate total_price the 'higher level classes' call on the methods of the instances provided in the 'lower level' instead of calling on them directly as in Implementation A.

7. Does total_price directly manipulate the instance variables of other classes?

    Implementation A - There is a small degree of manipulation with the entries through the loop.

    Implementation B - No, not in this case that I could tell.

8. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

    Implementation B -  It is much easier to change the logic of the price method and provide/add a 'discount' depending on what is considered bulk. Thus defining what is considered 'bulk' and worthy of a discounted rate, then setting up that discount in the price method as a conditional could be one way to potentially go about this.

9. Which implementation better adheres to the single responsibility principle?

    Implementation B - This because the classes in B have both behaviour and state.  Adding that the methods of higher level classes don't rely directly on the lower level classes.

10. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

    Implementation B - This because the classes components are in my opinion what I would call more 'self-reliant' and work more cohesively together due to that.
