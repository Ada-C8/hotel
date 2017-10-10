What classes does each implementation include? Are the lists the same?
* Implementation A includes CartEntry ShoppingCart and Order.
* Implementation B also includes CartEntry, ShoppingCart and Order

Write down a sentence to describe each class. CartEntry knows the unit price of each product and the quantity added. ShoppingCart gathers all the entries and Order initialize a ShoppingCart instance and calculates the total price.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper. The Order class initializes a ShoppingCart instance, the ShoppingCart class is initialized with an empty entries array that will contain CartEntry's instances. I do not understand at which point the CartEntry's instances get added to the ShoppingCart in either implementation.

What data does each class store? How (if at all) does this differ between the two implementations? The CartEntry class stores the unit_price and the quantity of each product. The ShoppingCart class stored an array of CartEntry's instances. The Order class stores the SALES_TAX constance.

What methods does each class have? How (if at all) does this differ between the two implementations? In implementation A, CartEntry and ShoppingCart have no methods and Order has a total_price method. In implementation B, CartEntry has a price method, ShoppingCart has a price method and Order has a total_price method.

Consider the Order#total_price method. In each implementation:

Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In implementation A, logic to compute the price is retained in Order. In implementation B, it is delegated to "lower level" classes.

Does total_price directly manipulate the instance variables of other classes?
It does in implementation A but not in implementation B.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Implementation B would be easier to change because only its price method would need to be adjusted to account for situations where items are bought in bulk.

Which implementation better adheres to the single responsibility principle?
Implementation B, because classes know less about each others (mainly, Order know less about CartEntry)

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B is more loosely coupled .
