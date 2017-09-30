

What classes does each implementation include?

Implementation A:
CartEntry
ShoppingCart
Order

Implementation B:
CartEntry,
ShoppingCart,
Order

Are the lists the same? Yes

Write down a sentence to describe each class.

CartEntry - for storing information about cart entry
ShoppingCart - represents a shopping cart and keeps list of entries
Order - represents a sales order and contains shopping card. This class calculates the total class of the order

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
 Order class contains an instance of ShoppingCard. ShoppingCard contains list of CartEntry objects.


What data does each class store? How (if at all) does this differ between the two implementations?
CartEntry stores unit_price and quantity
ShoppingCart stores list of CartEntry objects
Order class stores sales tax and an instance of ShoppingCart
Both implementations store the same data.


What methods does each class have? How (if at all) does this differ between the two implementations?
First implementation:
CartEntry and ShoppingCart have methods to initialize the fields
Order has initialize method that creates an instance of ShoppingCart class and total_price method that calculates total price of the order.

Second implementation:
CartEntry class has initialize method that initializes  given data (unit_price and quantity), and 'price' method, which calculates price by multiplying unit_price with quantity
ShoppingCart class has initialize method that 'initializes' entries field and it's own 'price' method that calculates total price of all entries.
Order class also has initialize method that creates an instance of ShoppingCart class and stores in an instance variable called @cart and total_price method that calculates the total value of price including sales tax.


Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In first implementation:
it's retained in Order. It has access to other class's fields and calculates price in itself by reaching out to the data in classes CartEntry and ShoppingCart. It's called 'feature envy'.

In second implementation: it's delegated to lower level classes to compute their own price.  

Does total_price directly manipulate the instance variables of other classes?
It does not manipulate instance variables of other classes, but it reads them(only in implementation A).

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
It's easier to add on the second implementation, because all the information needed for bulk price calculation is in one place (inside CartEntry class). Inside the CartEntry class's 'price' method we just adjust the price based on the quantity. Whereas in implementation A we have to add this logic inside the loop where other calculations are also happening.
Which implementation better adheres to the single responsibility principle? Implementation B is better, because each class has one and only one responsibility
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled? Implementation B, because Order class doesn't access (depend on/envy) instance variables of other classes.
Once you've responded to the prompts, git add design-activity.md and git commit!



Revisiting Hotel
In Hotel#reserve_room_from_block method I was modifying instance variables of the Block object. I refactored these modifications into a new method (Block#reserve_a_room) and calling this method from Hotel class. This design is better for multiple reasons:
1. Block class is more cohesive now.
2. Coupling between Hotel and Block classes is reduced.
3. If I need to rename instance properties of the block class I have to modify less places
