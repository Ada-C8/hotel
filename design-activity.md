1. What classes does each implementation include? Are the lists the same?
A: CartEntry, ShoppingCart, Order
B: CartEntry, ShoppingCart, Order
Yes they are the same classes, but they have different methods within them.

2. Write down a sentence to describe each class.
CartEntry is all about initializing the product- figuring out how many products there are (quantity) and what the corresponding unit price is (unit_price). The difference between the two (A & B) is that in A, CartEntry grants full access (read and write) to those two variables whereas B does not. B also includes a price method that multiplies and returns those two integers together.

ShoppingCart is similar in both A & B in that it collects the entries the customer wants by initializing an empty array that assumably will be filled up by a customer's ShoppingCart. Again, A allows reading and writing access whereas B does not. B also includes another method, again called price. This method will sum the total of the entire shopping cart, based on the entries that are provided. This is a bit confusing in that there is already a price method created in the class above, but I think that is okay because each will only ever be called within their particular class.

The last class in each is called Order. Order in both initializes the instance of the cart by creating a new instance of the ShoppingCart class. They each have a method called total_price. Implementation A references the instance variable entries from ShoppingCart and unit_price as well as quantity from CartEntry to calculate and return the total, which is *a lot of logic work to be done...* I think Metz would call this a potential danger zone. Whereas B only calls on the ShoppingCart class and it's price method.   

3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
A: The Order class pulls from both of the prior classes (CartEntry and ShoppingCart). The first two classes do the prep work almost for the Order class to then execute the logic and put it all together. Essentially, the first two classes in A are initializing variables in preparation for the Order "Master" class. They only hold the state. There is no behavior, which is a bad thing.
B: Has a method in each class. In it's Order class, it is only calling on ShoppingCart and using the method from it's class (price). I am going to make the assumption that each CartEntry becomes an entry in ShoppingCart. The Order class initializes the instance of the ShoppingCart, which already includes CartEntries.

4. What data does each class store? How (if at all) does this differ between the two implementations?
A: A stores the unit_price, quantity, entries, the constant sales_tax, an instance of the ShoppingCart, and the total_price (sum).
B: B stores the unit_price, quantity, the calculated price of those two variables multiplied together, the entries, the price of those added together, the constant sales_tax, an instance of the ShoppingCart, and the total_price (sum).
So essentially, B stores a whole lot more, BUT at least it performs the related logic in the correct class.

5. What methods does each class have? How (if at all) does this differ between the two implementations?
A: Beyond the initializing method in each class, Implementation A only has the total_price method, which makes it this scary master class that is heavily relying on the instance variables from the first two classes. Essentially, if any changes were to be made to those first two classes, a negatively cascading ripple effect might occur in which everything is broken.
B: Building off of the initialized methods in each class, B has two price methods that handles the logic within each class, and also a total_price method in the Order class.

6. Consider the Order#total_price method. In each implementation:
  ⋅⋅* Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
The logic is all done for A in the total_price method. BUT for B, the logic each class is done in the particular classes.

  ⋅⋅* Does total_price directly manipulate the instance variables of other classes?
For A, total_price directly manipulates the instance variables to execute the calculation. B initializes an instance of ShoppingCart in the Order class and uses it's price method but that is necessary.

7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
I believe B is easier to modify so I would go with that implementation. I would change the code by adding bulk_discount logic if the quantity in CartEntry got over a particular number. I would still have the method end at the Order class calculating a total_price, but I would add in a route that handled that bulk logic in it's own class to stick with the Single Responsibility mantra.

8. Which implementation better adheres to the single responsibility principle?
I believe B because it is easier to manipulate. Each class is doing its necessary logic for each class. A's Order class is too powerful and is manipulating the state of the other classes as opposed to calling their methods.

9. Bonus question once you've read Metz ch. 3:
  ⋅⋅* Which implementation is more loosely coupled?
I would say that B has been "decoupled" to the best of its ability in that, yes there are still dependencies between the classes, but only the necessary ones. Metz says that if an object knows what to ask for, it relies on less. It knows to ask another object for what it wants and trusts that it will receive it. If an object is dictating to another object how to give it what it wants, it knows more that it should about that other object (and possibly other objects THAT object knows), which goes back to tight coupling. It's better for an object to ask "what" instead of tell "how"... leading it to be loosely coupled.

## HOTEL ACTIVITY:
1. Identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class.

My Block class definitely needs to be reworked. I was not happy with it when I submitted it so I am ready to revisit it and try to tackle it's flaws. The logic for Block might live in too many places. Right now, the Reservations class contains methods that pertain to the Block class because the block reservation would be modifying the reservations list and thus I thought it should go with the rest of the reservations. But I am still a bit unsure what the best route is. I want 

Also, I tried my best to fix my naming conventions (taking the word array out of the variable names) and also tried to fix my check_availability method based on Jamie's feedback. **** Q for Jamie: Does that method look better now?

2. Describe what changes you would need to make to improve this design, and how why the resulting design would be an improvement.

So I am trying my best to clean up my Block class to make single responsibility happen. I am trying to organize my methods and rewrite them so that the attributes are not modifying the attributes of another class, as it was doing previously. If anything, I will want them to just call on the other class' methods.
