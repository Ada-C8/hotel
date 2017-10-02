###What classes does each implementation include? Are the lists the same?
Both implementations use three classes: CartEntry, ShoppingCart and Order.  However, they differ in that B's classes has price methods instead of attr_accessors.
###Write down a sentence to describe each class.
CartEntry: Is initialized with a unit price and quantity.  B's can tell you the price, while A's gives you attr_accessors to the price and quantity.
ShoppingCart: Is initialized with an empty array to called entries.  B's can tell you the total price of the all of the entries, while A's gives your attr_accessor to the entries.
Order: Creates an instance of a shopping cart and has a constant variable to store sales tax.
###How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Orders hold a shopping cart, they can tell you the total price with sales tax included.  A shopping cart holds CartEntry objects in an array.
###What data does each class store? How (if at all) does this differ between the two implementations?
Order holds sales tax as a constant variable and an instance of a cart as an instance variable.  ShoppingCart holds multiples instances of CartEntry objects as an instance variable within an array. CartEntry has a unit price and quantity as instance variables. The two implementations do not differ on this.  
###What methods does each class have? How (if at all) does this differ between the two implementations?
A's gives you attr_accessors for their object's instance variables.  However, B's has a separate method for "price." This allows for the data to remain private and from being modified.
###Consider the Order#total_price method. In each implementation:
###Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
A's computes the the total price by accessing the unit price and quantity for the objects and directly computing using those numbers.  However, B's implementation has a price method that gives you the price for each objects, so it just needs to grab the cart's price to use as a subtotal before adding the sales tax.  
###Does total_price directly manipulate the instance variables of other classes?
A's method does not currently change the instance variables, but they could if they make a mistake writing a method in Order. However, it would be impossible to do so in B's.
###If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
B's implementation would be easiest because you could just modify the price method to adjust when the quantity is above a certain number.  In A's implementation you would have to check it for each entry within the total price loop.  
###Which implementation better adheres to the single responsibility principle?
B!
###Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
###Once you've responded to the prompts, git add design-activity.md and git commit!

### Hotel
My hotel module is doing a lot!  It creates, modifies, and finds rooms, reservations and blocks.  Some of it can definitely be moved into the classes.  I refactored the available_rooms and blocked_rooms method to not rely so heavily on attr_readers from the classes.  Instead of manually checking the check in and check out date within the Hotel module, I updated it so the blocks and reservations can tell you if they are available or not within that date range.  
