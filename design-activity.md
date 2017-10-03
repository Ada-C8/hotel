# Hotel Revisited

----
## Design Activity

 1. What classes does each implementation include? Are the lists the same?
  - Each implementation has a class CartEntry, ShoppingCart, and Order. Yes.

 2. Write down a sentence to describe each class.
  - CartEntry represents the item being bought. ShoppingCart holds the items that are going to be bought. Order takes a shopping cart and calculates the final cost (including tax).


 3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  - ShoppingCart has-a CartEntry. And Order has-a ShoppingCart.

 4. What data does each class store? How (if at all) does this differ between the two implementations?
  - In both implementations, CartEntry contains ints of the item's individual price and the quantity. ShoppingCart also contains an array of entries. And Order contains an int for sales tax and has a in a cart with class ShoppingCart.

 5. What methods does each class have? How (if at all) does this differ between the two implementations?
  - In implementation A, the Order class contains the method price that does the calculation of the prices in the ShoppingCart. But in implementation B, each class has its own individual price method that calculates the total price in relation to the data it contains. CartEntry has a price method that calculates the total price of an item. ShoppingCart uses CartEntry's price method and calculates the total price in the cart. And Order takes ShoppingCart's price method and calculates it with sales tax.

 6. Consider the Order#total_price method. In each implementation:

6a. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

- In Implementation A, the logic to compute the price is retained in Order and in Implementation B, the logic is delegated to other classes as well.


6b. Does total_price directly manipulate the instance variables of other classes?

 - total_price in either implementation does not change the value of the data contained in other classes. But in implementation A, it does call the attributes of other classes (ex. entry.unit_price). While in implementation B, it only calls the @cart.price of the ShoppingCart it has at its instance method.

 7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  - In implementation A, you would have to add an if logic inside the total_price method's each loop to check if each entry.quanitity is more than a certain amount. Implementation B would be easier to modify because you would only have to change the implementation in CartEntry and the implementation doesn't depend on other classes' attributes.

 8. Which implementation better adheres to the single responsibility principle?
  - Implementation B

 9. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  - Implementation B, because it doesn't need to know the specific attributes in other classes (unlike in Implementation A that calls attributes from CartEntry), just that the cart it has will have a price

---

## Hotel (Re-)Impelementation

Based on the answers to the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how why the resulting design would be an improvement.

 - In my Hotel program, I have a lot of places that are tightly coupled by creating my methods that create instances of Reservation and BlockReservation in my Admin class. Instead, I should be able to create those instances in their respective classes. For example, in my Admin class I have a total_cost method that takes in a reservation object and in the method it knows the attributes that are inside a Reservation with a Room class.

 Looking back at Hotel's Admin class, I could move the logic to calculate the cost to Reservation. And also the error messages that deal with checking valid check-out and check-in dates since Reservation also takes in these values. Moving the logic would help make the responsibilities of each class more defined and contained so that not everything's in Admin.
