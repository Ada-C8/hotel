What classes does each implementation include? Are the lists the same?
class CartEntry, ShoppingCart, Order - Yes

Write down a sentence to describe each class.
CartEntry From B - Takes an instance of unit price and multiplies by a quantity amount that can later be added to the cart.
Shopping cart initializes an empty array to put entries in and then price takes each entry adds it together into a sum and returns the sum
Order creates a new instance of shopping cart and adds up the subtotals and multiplies by the sales tax, which was assigned in this class.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Order needs ShoppingCart's entries, and the items in entries are instances of CartEntry.

What data does each class store? How (if at all) does this differ between the two implementations?
CartEntry stores the unit prices and number of items
ShoppingCart stores the entries in array form
Order stores a new instance of ShoppingCart and the Sales tax.
Yes, but price/subtotals are calculated differently. 

What methods does each class have? How (if at all) does this differ between the two implementations?
In 'A', CartEntry and ShoppingCart have accessor methods, and Order has most of the logic in the total_price method, by using those instance variables and their stored value. 
In 'B', CartEntry and ShoppingCart have price methods (removing the necessity of accessor methods), and Order has the total_price method, which adds tax to the ShoppingCart's price.

Consider the Order#total_price method. In each implementation:
*Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In 'A' no, it is done in Order. In 'B' yes, it is delegated as each class handles its own price, and order just puts it all together.
*Does total_price directly manipulate the instance variables of other classes?
Not for 'B'. 'A' puts the entries through a loop and does manipulate them somewhat.  

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
'B' would be easier to modify - could add to the CartEntry if x quantity is reached, discount (subtract) by some percent. In 'A' the logic would have to be in Order, and that could get confusing. 

Which implementation better adheres to the single responsibility principle?
'B'

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled? 
'B' - components in classes seem to be less reliant on other classes because the calculations are kind of done 'in house' so to speak. 
