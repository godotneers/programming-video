# Solutions

This file contains some solutions for the challenges. Remember that there
is always more than one way to solve a problem, so if your solution looks
different than the one shown here this is totally fine - if your program solves
the problem it is a valid solution.

## Challenge 1

A very simple solution to this problem would be:
	
func what_should_i_do():
	step_forward()
	step_forward()
	turn_right()
	step_forward()
	step_forward()
	turn_right()
	step_forward()
	step_forward()
	turn_right()
	step_forward()
	step_forward()
	turn_right()
	
If we look at this we see that we repeat the same actions four times. So this
can be simplified with a `for` loop like this:
	
func what_should_i_do():
	for i in 4:
		step_forward()
		step_forward()
		turn_right()

And then we only need four lines of code to solve the problem.


## Challenge 2

We can start with the solution from challenge 1, but this time Mr. G. needs to do two additional
steps forward so a simple solution would be:
	
func what_should_i_do():
	for step:int in 4:
		step_forward()
		step_forward()
		step_forward()
		step_forward()
		turn_right()

And this works fine. We can see that we repeat the `step_forward` call four times, so we can replace
these with a `for` loop again. Note that the inner `for` loop is properly indented so the computer
knows to run it as part of the outer `for` loop:

func what_should_i_do():
	for step:int in 4:
		# we already declared the step variable so 
		# we need to use a separate variable for the
		# inner loop. We call it another_step.
		for another_step:int in 4: 
			step_forward()
			
		# Note how turn_right is not part of the inner loop
		# so it is not as far indented as the 
		# call to step_forward above
		turn_right()
	
If you ignore the comments, this is just four lines of code so this solves the additional challenge.


## Challenge 3

Here we can use a `while` loop in combination with the `is_item_before_me` variable to walk
Mr.G. forward until he hits a coffee cup.

func what_should_i_do():
	# we need to repeat this 4 times, one time for each direction
	for step:int in 4:
		# we can also express is_item_before_me == false like this
		while not is_item_before_me:
			step_forward()
			
		# Note again, how turn_right is not part of the inner while loop
		# we only want to turn right after we have hit the coffee cup
		turn_right()

If you put the coffee cup to the wrong place or forget to move it, the while loop may never end. 
If this is the case your program will freeze. You can still use the stop button at the upper
right of Godot's main window to stop the program in this case.
