##### What classes does each implementation include? Are the lists the same?  
Implementation A & B both include three classes: CartEntry, ShoppingCart, and Order. The class names are the same, but attr-s and methods are different.

##### Write down a sentence to describe each class.  
**CartEntry:** Initializes a product object (unit_price, quantity). **ShoppingCart:** Is a single object (array) that holds the CartEntry objects, but not actually coupled with CartEntry. **Order:** Initializes a new ShoppingCart object, both versions have a SALES_TAX constant and total_price method.

##### How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.  
Order creates a new ShoppingCart object, which creates an @entries array. The @entries array in ShoppingCart holds CartEntry objects. When total_price is called in Order, the method iterates over each CartEntry to gets its unit_price and quantity and add it to the sum, then adding tax.

##### What **data** does each class store? How (if at all) does this differ between the two implementations?  
**CartEntry** holds a product's price and how many are being purchased. **ShoppingCart** will hold an array of CartEntry objects. **Order** holds the individual ShoppingCart object. The implementations seems to hold the same data, but different methods.

##### What **methods** does each class have? How (if at all) does this differ between the two implementations?  
Implementation A & B both have a total_price method in the Order class. In implementation A, this is the only method. In implementation B, CartEntry and ShoppingCart have additional methods for price.

##### Consider the Order#total_price method. In each implementation:
**-Is the logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**  
Implementation A: retained in Order. Implementation B: it is delegated to lower level classes.  

**-Does total_price directly manipulate the instance variables of other classes?**  
My understanding is that neither implementations change/manipulate the instance variables; however, Implementation A could manipulate the variables because of the attr_accessors in CartEntry and ShoppingCart.

##### If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?  
Implementation B, the adjustment can be made in the price method within the CartEntry class.

##### Which implementation better adheres to the single responsibility principle?  
Implementation B, the added method for price makes it single responsibility. If a change was made within the class, it should not affect methods outside of the class.

##### **Bonus question** once you've read Metz ch. 3: Which implementation is more loosely coupled?  
Implementation B, everything is contained within a class. Changes to names would only affect things within the class (unless the price method was re-named). Whereas in implementation A, any name/function changes in any class would affect Order.total_price.


**Now that we've got you thinking about design, spend some time to revisit the code you wrote for the Hotel project. For each class in your program, ask yourself the following questions:**

###What is this class's responsibility?
You should be able to describe it in a single sentence.

###Is this class responsible for exactly one thing?

###Does this class take on any responsibility that should be delegated to "lower level" classes?

###Is there code in other classes that directly manipulates this class's instance variables?

##Activity

Based on the answers to the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how why the resulting design would be an improvement.

##### Answer

My find_available method in class California directly accessed the instance objects of rooms. Class California took an additional role when availability of a room could easily be determined within the class Room.  

Changes to be made: create isAvailable method in room that returns the room number if it is available, modify find_available to use isAvailable method on each room.  

This makes class California more loosely coupled to class Room. Modifications in either class will be less likely to break functionality.
