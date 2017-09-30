## Prompts

1. **What classes does each implementation include? Are the lists the same?**

   Each implementation includes the same classes:
     + a CartEntry class
     + a ShoppingCart class
     + an Order class

2. **Write down a sentence to describe each class.**

   + `CartEntry`: This is a single kind of item in the online shopping cart, and it tracks the unit price of the item, and the quantity of that item ordered.
   + `ShoppingCart`: This is an object representing the actual shopping cart, and it consists of an array of entries (items in the shopping cart).
   + `Order`: This is the online order, which contains a shopping cart, and it uses sales tax to calculate the total price of the cart contents.

3. **How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**

   A `ShoppingCart` has a `CartEntry`, and an `Order` has a `ShoppingCart`--i.e. `Order` depends on `ShoppingCart`, which depends on `CartEntry`.

4. **What _data_ does each class store? How (if at all) does this differ between the two implementations?**

   The classes in each implementation store the exact same data. `CartEntry` stores `unit_price` and `quantity`, `ShoppingCart` stores `entries` (which are cart entries), and `Order` stores `SALES_TAX` (a constant) and a cart, which is a `ShoppingCart` object.

5. **What _methods_ does each class have? How (if at all) does this differ between the two implementations?**

   Aside from the accessor methods, Implementation A only has one defined method, which calculates the total price of an order, which means it's more tightly coupled to both the `ShoppingCart` and `CartEntry` classes, because it depends on `ShoppingCart` being an array of CartEntries, and each `CartEntry` having a `unit_price` and `quantity`.

   Implementation B, on the other hand, uses methods in both the `CartEntry` and `ShoppingCart` classes to calculate the price of each `CartEntry` object and the price of each `ShoppingCart` object. This decouples `ShoppingCart` from `CartEntry` (it calls `CartEntry`'s price method rather than manipulating `CartEntry`'s variables directly), as well as decoupling `Order` from both `ShoppingCart` and `CartEntry`.

6. **Consider the `Order#total_price` method. In each implementation:**
  + Is logic to compute the price delegated to "lower level" classes like `ShoppingCart` and `CartEntry`, or is it retained in `Order`?
  + Does `total_price` directly manipulate the instance variables of other classes?

    + Implementation A: (see above) No, the logic to compute the price isn't delegated to the lower-level classes. Instead, `total_price` directly manipulates the instance variables of both `ShoppingCart` (it gets `@entries` from `ShoppingCart`) and `CartEntry` (for each `CartEntry`, it gets `@unit_price` and `@quantity`).

    + Implementation B: (see above) Yes, the logic is delegated to the lower-level classes. `CartEntry` is responsible for calculating its own price, and `ShoppingCart` is responsible for calculating the total price of its contents. `Order` then simply calls the price method for `ShoppingCart` and adds sales tax to calculate the total price.

7. **If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

   This would mean changing the `CartEntry` class so that if quantity exceeds a particular amount, `unit_price` is then set to a discounted rate. Implementation B is easier to modify, because it already has a `price` method, so it simply means modifying that `price` method to account for bulk orders. However, Implementation A has no such method—all the calculations are taken care of in the `Order` class, which means the `total_price` method will become more complex.

8. **Which implementation better adheres to the single responsibility principle?**

   Implementation B because each class calculates its own price using its own instance variables.

9. **Bonus question: Which implementation is more loosely coupled?**

   Implementation B
