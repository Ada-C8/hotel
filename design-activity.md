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
#### Block
##### What is this class's responsibility? (You should be able to describe it in a single sentence.)
Contains & manages necessary information for a block reservation
##### Is this class responsible for exactly one thing?
Yes
##### Does this class take on any responsibility that should be delegated to "lower level" classes?
No
##### Is there code in other classes that directly manipulates this class's instance variables?
No - Reservation reads the #discount_rate variable but does not manipulate it

#### Hotel
##### What is this class's responsibility? (You should be able to describe it in a single sentence.)
Contains and manages all types of reservations
##### Is this class responsible for exactly one thing?
Yes
##### Does this class take on any responsibility that should be delegated to "lower level" classes?
No? Room rates are currently set by the ROOM_COST constant (as room cost is always 200/night) within the Hotel class, while theoretically if these were to change they would have to come from somewhere else, but would probably still be accessed/assigned within the Hotel#initialize method.
##### Is there code in other classes that directly manipulates this class's instance variables?
No

#### Reservation
##### What is this class's responsibility? (You should be able to describe it in a single sentence.)
Contains & manages necessary information for a room reservation
##### Is this class responsible for exactly one thing?
Yes
##### Does this class take on any responsibility that should be delegated to "lower level" classes?
No
##### Is there code in other classes that directly manipulates this class's instance variables?
No

#### Room
##### What is this class's responsibility? (You should be able to describe it in a single sentence.)
Contain basic data on a given room
##### Is this class responsible for exactly one thing?
Yes
##### Does this class take on any responsibility that should be delegated to "lower level" classes?
No
##### Is there code in other classes that directly manipulates this class's instance variables?
No

#### DateRange (module)
##### What is this class's responsibility? (You should be able to describe it in a single sentence.)
Provide necessary methods for working with ranges of dates
##### Is this class responsible for exactly one thing?
Yes
##### Does this class take on any responsibility that should be delegated to "lower level" classes?
No? One method (#validate) might be better off being added to the Date class
##### Is there code in other classes that directly manipulates this class's instance variables?
No (n/a)
