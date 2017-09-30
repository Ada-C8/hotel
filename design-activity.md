What classes does each implementation include? Are the lists the same?

Each implementation includes a CartEntry class, a ShoppingCart class, and an Order class. They are the same.

Write down a sentence to describe each class.

CartEntry - A cart entry that takes in a price and quantity.
ShoppingCart - Stores all the entries.
Order - Sets up the ShoppingCart to be totaled.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

The ShoppingCart will hold multiple entries of CartEntry in an array. Once an order is ready to be placed, Order calculates the total to include sales tax.

What data does each class store? How (if at all) does this differ between the two implementations?

CartEntry stores the unit_price and quantity.
ShoppingCart stores entries.
Order stores an instance variable called @cart based on a new instance of ShoppingCart.new

The main difference between these two implementations is that in the first example, everything is calculated inside of the Order class.
In the second example, CartEntry creates a price method to calculate an entry. ShoppingCart also creates a price method that calculates the total inside a shopping cart by looping through each entry and adding its total to sum by referencing the price method from CartEntry. Finally, Order can take what's in the ShoppingCart and utilize ShoppingCart's price method to return a total_price that includes SALES_TAX.

What methods does each class have? How (if at all) does this differ between the two implementations?

The first implementation has one method for total_price that creates a total price.
The second implementation has three price methods that are later accessed by other classes in order to calculate their prices.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

In Implementation A, logic to compute price is retained in Order. In Implementation B, logic for price is delegated to ShoppingCart and CartEntry.

Does total_price directly manipulate the instance variables of other classes?

In A, yes. In B, it does not. total_price is only dealing directly with the instance variable @cart, which is created in the initialization method of Order.

If we decide items are cheaper if bought in bulk, how would this change the code?

We could add a Bulk class that takes in unit prices at different quantities. This would involve changing how shopping cart is structured.

Which implementation is easier to modify?
It would be easier to implement using implementation B because we could create a new class, then alter ShoppingCart to take in those bulk items as well.

Which implementation better adheres to the single responsibility principle?
Implementation B adheres to the single responsibility principle because its responsibility has both a state and behavior. Logic isn't all in one class, it's  delegated to the classes who have that behavior.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Based on the answers to the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how why the resulting design would be an improvement.

My Hotel class takes on a lot of roles. It has the total method, which should be in Reservation because it is directly related to those instance variables. I decided that Hotel's job would be to manage rooms, but it does a lot of date verification, so I should make that into its own class.
