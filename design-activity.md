# Hotel Revisited

#### Prompts

Once you have read through the above code, add a file to your Hotel project called `design-activity.md`. This file will be submitted with the rest of this exercise. In that file, please respond to the following prompts:

- What classes does each implementation include? Are the lists the same?
  - implementation A: CartEntry, ShoppingCart, Order
  - implementation B: CartEntry, ShoppingCart, Order
  - Yes, they are the same
- Write down a sentence to describe each class.
  - CartEntry is a representation of an item with a quantity and price
  - ShoppingCart is a collection of CartEntries
  - Order itemizes the ShoppingCart and determines a total
- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  - Order has-a ShoppingCart which has-a lot of CartEntries
- What **data** does each class store? How (if at all) does this differ between the two implementations?
  - CartEntry: price and quantity
  - ShoppingCart: a collection of CartEntry
  - Order: ShoppingCart
  - no difference between implementations
- What **methods** does each class have? How (if at all) does this differ between the two implementations?
  - implementation A has only initialize methods for CartEntry and ShoppingCart
  - implementation B has additional price methods for CartEntry and ShoppingCart
  - both implementations have the same Order with initialize and total_price methods
- Consider the `Order#total_price` method. In each implementation:
    - Is logic to compute the price delegated to "lower level" classes like `ShoppingCart` and `CartEntry`, or is it retained in `Order`?
    - Does `total_price` directly manipulate the instance variables of other classes?
      - in implementation A, Order#total_price has to read the price and quantity of each CartEntry in the ShoppingCart, therefore is not delegating and does directly manipulate the instance variables.
      - in implementation B, the accessing of instance variables are delegated to the lower level classes of CartEntry and ShoppingCart. Both these methods create methods to access price information therefore this implementation does not directly manipulate instance variables of other classes
- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  - An if-statement would have to be added to select the correct discount price. In implementation A, the author would most likely place this in Order#total_price, which would complicate the code and manipulate instance variables of the other class. This would be easier to add to implementation B in the price method so the Order#total_price would not be affected at all.
- Which implementation better adheres to the single responsibility principle?
  - implementation B because behavior and state is delegated to lower level classes, therefore other classes don't need to access their instance variables directly
- Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Once you've responded to the prompts, `git add design-activity.md` and `git commit`!

## Revisiting Hotel

Now that we've got you thinking about design, spend some time to revisit the code you wrote for the Hotel project. For each class in your program, ask yourself the following questions:
- What is this class's responsibility?
    - You should be able to describe it in a single sentence.
    - Room keeps track of a list of rooms and availability
    - Reservation makes and stores reservations
- Is this class responsible for exactly one thing?
  - reservation has too many responsibilities
- Does this class take on any responsibility that should be delegated to "lower level" classes?
  - Reservation is too large - reservation can become a lower level class (it's initialization can also be made simpler)
- Is there code in other classes that directly manipulates this class's instance variables?
  - room does not directly manipulate reservation data but has to access to access it's own data

### Activity
Making a whole new parent class and reorganizing methods to create and store reservations would break all my tests. Instead to reduce complexity of my reservation class, I have simplified my initialize method and reduced its responsibilities to manage dates. Though an overall better design would be to have a parent class to manage and store reservations, this design works within my hotel framework. It makes it cleaner and easier to read with the responsibilities rearranged to methods.
