# Activity: Evaluating Responsibility

* **What classes does each implementation include? Are the lists the same?**

Each implementation includes the following classes (They are the same):
CartEntry
ShoppingCart
Order


* **Write down a sentence to describe each class.**

CartEntry: This class includes the quantity and price of each item in the ShoppingCart

ShoppingCart: This class includes an array of entries.

Order: This class calculates the total price of the order including sales tax.

_In implementation B the CartEntry calculates the cost of the entry and the ShoppingCart calculated the total (with sales tax being included in the order).  In implementation A the Order combines all the calculations for price._


* **How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**

ShoppingCart holds an array that can be filled with instances of CartEntry (or anything else for that matter, since it isn't hard coded into the ShoppingCart class.) Order has-a ShoppingCart

* **What data does each class store? How (if at all) does this differ between the two implementations?**

CartEntry: unit price and quantity of the item in the cart
ShoppingCart: collection of entries
Order: an instance of ShoppingCart, and the constant value of the SALES_TAX.

The data stored in each class is the same for both classes, the difference is that in implementation A the Order is responsible for all the pricing calculations whereas in Implementation B, each class has a method to communicate the calculation of the price.

* **What methods does each class have? How (if at all) does this differ between the two implementations?**

A:
CartEntry: attr_accessor for unit price and quantity
ShoppingCart: attr_accessor for entries
Order: total_price to calculate the total price of the Order

B:
CartEntry: same as A with additional price method to calculate the price of the CartEntry
ShoppingCart: same as A with an additional price method to calculate the sum of all the CartEntry prices
Order: same, but the total_price method receives a method from the ShoppingCart to receive the total price before tax and the uses that to calculate the total_price with tax. This is a better implementation since the calculation done on the entries is done in their respective methods instead of in the Order class.

* **Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**
A: computing the price is all retained in Order
B: delegated to "lower level" classes

* **Does total_price directly manipulate the instance variables of other classes?**
I struggle with this question in terms of what it means to manipulate an instance variable. total_price does not change the value of any of the instance variables from other classes, but it does make calculations using the instance variables.

* **If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

We would need to write a conditional statement into the price. This would be easier to modify in implementation B.

* **Which implementation better adheres to the single responsibility principle?**

Implementation B better adheres to the single responsibility principle.

* **Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**

Implementation B is more loosely coupled.
-------------------

# Revisiting Hotel Activity:

A change that I decided to make to my Hotel project included changes within several classes. I created a DateRange class that was a superclass for Reservations and Blocks. Since Blocks and Reservations need to utilize the same features such as a check_in date, a check_out date, and a way to check for room availability, this allowed for one class to take care of all those features as well as check for date validity.  This creates for code  that is more DRY as well as classes that are easier to re-use and change. Within the Hotel class I changed to responsibility for checking for an overlap between the dates requested to check in and the rooms in the hotel to the Date Range class.  My tests proved useful when I ran rake and found a few failures that were due to my change in code and they pointed me in the right direction. I found myself extremely grateful for the existence of tests!


-- create a date range class that is a superclass to reservation and block
-- take overlap from hotel class and put it into date range class.
