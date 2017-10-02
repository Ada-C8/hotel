### Activity
##### What classes does each implementation include? Are the lists the same?  

Yes, they are the same. Both implementations have:  
  * CartEntry
  * ShoppingCart
  * Order


##### Write down a sentence to describe each class.  

Implementation A:  
* CartEntry
  * Contains basic pricing info entry
* ShoppingCart
  * Contains CartEntry objects
* Order
  * Contains and totals a ShoppingCart object

Implementation B:
* CartEntry
  * Manages all pricing info of a single entry
* ShoppingCart
  * Contains and totals CartEntry objects
* Order
  * Contains and totals ShoppingCart, accounting for sales tax

##### How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.  
* Order _has a_ ShoppingCart
* ShoppingCart _has many_ CartEntries

##### What data does each class store? How (if at all) does this differ between the two implementations?  
Implementation A:  
* CartEntry
  * Unit price
  * Unit quantity
* ShoppingCart
  * List of CartEntries
* Order
  * ShoppingCart
  * Total price of all CartEntries in ShoppingCart

Implementation B:
* CartEntry
  * Unit price
  * Unit quantity
  * Total entry price
* ShoppingCart
  * List of CartEntries
  * Total of all CartEntry prices
* Order
  * ShoppingCart
  * Total price of ShoppingCart with tax

##### What methods does each class have? How (if at all) does this differ between the two implementations?  
Implementation A:  
* CartEntry
  * #unit_price
  * #quantity
* ShoppingCart
  * #entries
* Order
  * #cart
  * #total_price

Implementation B:
* CartEntry
  * #price
* ShoppingCart
  * #price
* Order
  * #total_price

Implementation A uses attr_accessor methods to make all of the data contained within each class publicly accessible. Implementation B keeps this data private and uses a #price method on CartEntry and ShoppingCart classes to return only the necessary information (in this case, price).

##### Consider the Order#totalprice method. In each implementation:  

##### Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?  

Implementation A requires the Order#total_price method to dig through the ShoppingCart class and into the CartEntry class to directly access its variables, while Implementation B takes the returned value of ShoppingCart#price and performs its logic around that.

##### Does totalprice directly manipulate the instance variables of other classes?  

Implementation A directly reads the instance variables of the ShoppingCart and CartEntry classes, though it does not modify them. Implementation B does not directly read or modify any other class' instance variables.

##### If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?  

Implementation B would be easier to modify, as this change would only affect the CartEntry class, which could be updated to modify price based on quantity. In Implementation A, this would require the Order#total_price method to perform this additional logic within the same method where it is already calculating the total _and_ applying sales tax.

##### Which implementation better adheres to the single responsibility principle?  

Implementation B better adheres to this principle, as each class manages and encapsulates its relevant information.

##### Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?  

### Revisiting Hotel
Overall, I feel that I did a pretty good job of adhering to the single responsibility principle. The only thing that bothers me about my design is that the price of each room comes from a constant variable defined within the Hotel class, but since the current spec of the project is for all of the hotel's rooms to have a price of 200, I still think it makes the most sense for the time being. How I would refactor the code to account for varying room types would vary depending on how the rooms' prices were being determined, so there's nothing to change at the moment.

The change I _did_ make was to remove the #validate method from the DateRange class. My thought process behind the change was that the method (which converts valid input into a Date object if it isn't already one) only interacts with one date, and therefore should be part of the Date class, not DateRange.
