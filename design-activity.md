design-activity.md


1.What classes does each implementation include? Are the lists the same?

They both include CartEntry, ShoppingCart and Order.  They have the same classes.

2.Write down a sentence to describe each class.

CartEntry = describes a single item in the cart.
ShoppingCart = describes and holds all the items in the cart.
Order = describes any other logic that has to do with making an order (ex. here sales tax, but possibly shipping charge in the future.)

3.How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

Order has a ShoppingCart.
ShoppingCart has a(or many) CartEntries.

4.What data does each class store? How (if at all) does this differ between the two implementations?
Order stores the sales tax and the cart.
Cart stores what CartEntries are in the cart.
CartEntries stores the item_price and how many of them are in the cart.

In the two implementations the instance variables and the constant stored in the classes are the same, but the methods used to calculate other properties (ex. price) are distributed differently.

5.What methods does each class have? How (if at all) does this differ between the two implementations?

In implementation A, all the logic for the price of an order is contained within the Order class, which means that the Order class needs to read the entries from the ShopingCart class, and from those find the quantity and unit_price from the CartEntry class.  

Implementation B is a more loosely coupled way of doing the same calculation.  In this the CartEntry class finds the cost of that item, the ShoppingCart class counts sums all the items, and the Order class just adds on the tax.  


6.Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
I basically answered this above, but in implementation A all the logic is in Order, and in B it is delegated to lower classes.

7.Does total_price directly manipulate the instance variables of other classes?
In implementation A it directly reads the instance variables of other classes.

8.If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

In either implementation you could add a method to reset the unit_price if the quantity was above some threshold.
In implementation B it would also be easy to add a constant to the CartEntry#price calculation depending on the quantity.

9.Which implementation better adheres to the single responsibility principle?
Implementation B

10.Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B
