### Part 1
|  Question 	|  Answer 	|
|---	|---	|
|  What classes does each implementation include? Are the lists the same?	|  `CartEntry`, `ShoppingCart`, and `Order` -- yes. 	|
|  Write down a sentence to describe each class.  |  `CartEntry` takes some number of one item and puts them into a single object price that can be added to a cart. `ShoppingCart` takes all of the `CartEntry`s and puts them together. `Order` takes everything in the `ShoppingCart` and adds tax to the price. |
|  How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.  | `Order` needs a `ShoppingCart`'s `@entries`, and each item in `@entries` is an instance of a `CartEntry`.  |
|  What data does each class store? How (if at all) does this differ between the two implementations?  |  `CartEntry` stores number of items and price, `ShoppingCart` stores an array of `CartEntry`s, and `Order` stores an instance of `ShoppingCart`. As far as I can tell, this is the same across both.  |
|  What methods does each class have? How (if at all) does this differ between the two implementations?  |  In **Implementation A** `CartEntry` and `ShoppingCart` have `attr_accessor` methods, and `Order` has most of the logic in the `total_price` method, by using those instance variables and their stored value. In **Implementation B** `CartEntry` and `ShoppingCart` have `price` methods thereby removing the necessity of `attr_accessor` methods, and `Order` has the final `total_price` method that essentially only adds tax to the `ShoppingCart`'s price.  |
|  Consider the Order#total_price method. In each implementation:  |---  |
|  * Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?  |  In **A** - no. `Order` does all the work. In **B**, each piece is responsible for its own price, and `Order` just adds the final pieces together: `return subtotal + subtotal * SALES_TAX` |
|  * Does `total_price` directly manipulate the instance variables of other classes?  |  hmm. Manipulate - no. At no point does the `attr_writer` attribute of `attr_accessor` get used in either case, but interact with, in **A**, yes. The `total_price` method reads all the instance variables.   |
|  If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?  |  **B** would be easier to modify because you could simply add logic to `price` in `CartEntry` that says something along the lines of if a certain quantity is reached, discount the price by some percent. In **A** that logic would have to be in Order, and that could get messy. |
|  Which implementation better adheres to the single responsibility principle?  |  **B**  |
|  Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?  |    |

### Part 2

My Reservations class has way too much going on in it. Dan made some suggestions in his comments about moving some of the checking overlapping dates responsibility to the DateRange class, so I'm going to start there.

If I have time/inclination I might tackle some of the other problems from the comments, such as the way Block stores rooms and seeing all reservations for a given date. Also, it might be interesting to play with the idea of using args and defaults for all the initialize arguments....

The real problem with Reservations is the way it knows too much about what's going on in the other classes. It's repeatedly trying to access the attributes of other classes to check if they overlap, or to change reservation status. So hopefully moving some responsibility around will help take away some of that tight coupling.
