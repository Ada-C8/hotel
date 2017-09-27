
    **What classes does each implementation include? Are the lists the same?**

    Implementation A has the following classes: CartEntry, ShoppingCart, and Order

    Implementation B has the following classes: CartEntry, ShoppingCart, and Order

    The 2 implementations have the same classes.


    **Write down a sentence to describe each class.**

    CartEntry represents each entry, for example, in an online shopping cart. So it contains the unit price and quantity being purchased.

    ShoppingCart contains all the individual CartEntries.

    Order initalizes a new ShoppingCart and can calculate the total for everything in the ShoppingCart plus sales tax.

    **How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**

    See question above.


    **What data does each class store? How (if at all) does this differ between the two implementations?**

    For Implementation B:

    The CartEntry class knows the price for the quantity of that item being purchased.

    The ShoppingCart knows the price for all of the items being purchased.

    The Order knows the total price including sales tax.

    In contrast, for Implementation A, the Order Class is the only one who knows or can calculate any of the various totals.

    **What methods does each class have? How (if at all) does this differ between the two implementations?**

    In Implementation B, CartEntry has a price method. Implementation A does not have this method, and instead this logic is contained in the Order Class. In Implementation A, CartEntry has attribute accessor methods for unit_price and quantity, which would allow them to be read or written. In contrast, in Implementation B, those values are set during initialization of a new CartEntry.

    Similarly, in Implementation B, ShoppingCart has a price method to calculate the total cost for all the CartEntries in the ShoppingCart while i Implementation A, that logic as contained in the ShoppingCart.

    Finally, in Implementation B, ShoppingCart used the subtotal from the ShoppingCart and has a method to calculate total_price (taking the subtotal and adding sales tax), while in Implementation A, all of the price logic is done in one large method in ShoppingCart. The logic in the total_price method from Implementation A requires knowing things such as that cart entries are stored in an array that can be iterated over, so if that data structure would change, it would require the code for a whole different class to change as well.


    **Consider the Order#total_price method. In each implementation:
        Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
        Does total_price directly manipulate the instance variables of other classes?**

        In Implementation A, as discussed above, the total_price method does manipulate the instance variables of other classes. Implementation B does not.


    **If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

    I think implementation B would be easier to modify. A bulk discount would make most sense at the CartEntry class (because it knows the quantity of each item purchased). Logic could be added so that if the quantity was above a certain amount, the price was reduced by a certain percent. Adding this logic, should not require the code for the other 2 classes to be altered, and hence Implementation B would be easiest to change.

    **Which implementation better adheres to the single responsibility principle?**

    Implementation B

    **Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**

    Implementation B 
