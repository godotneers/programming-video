# Solutions

This file contains some solutions for the challenges. Remember that there
is always more than one way to solve a problem, so if your solution looks
different than the one shown here this is totally fine - if your program solves
the problem it is a valid solution.

## Challenge 1

Here it really makes sense to first write ourselves a helper function to find out
the name of the item before Mr. G. With this helper in place it then becomes rather 
easy to implement the actual logic for following the signs.

# We need to get the item name before us a lot and we always need to
# check if there is actually an item before us, so we use this helper
# function to simplify our code.
func get_item_name_before_me() -> String:
	# if there is no item before us, we just return an empty string
	if is_item_before_me == false:
		return ""
	# otherwise we return the item name of the item before us
	return item_before_me.item_name
	
func what_should_i_do():
	
	# We run this loop for as long as there is no plant before us. We use
	# a helper function to simplify our code here.
	while get_item_name_before_me() != "Plant":
		# If there is nothing before Mr.G just step forward
		if get_item_name_before_me() == "":
			step_forward()
			
		# If there is a turn left sign, turn left
		if get_item_name_before_me() == "Turn Left Sign":
			turn_left()
		
		# If there is a turn right sign, turn right
		if get_item_name_before_me() == "Turn Right Sign":
			turn_right()
	
	say("I have arrived!")


## Challenge 2

In case you didn't follow along with the video, here is the source code for the `TallyCounter`
class. Create a new file `tally_counter.gd` in the file system and then paste this code into this
new file:
	
# ------- START HERE -------

class_name TallyCounter
extends RefCounted

var current_count:int = 0


func count():
	current_count += 1
	
func reset():
	current_count = 0
	
# ------- END HERE -------
	
	
Now we're ready to use the counter. We KEEP the `get_item_name_before_me` function from challenge 1
but we need to make some changes to our `what_should_i_do_function`:
		
func what_should_i_do():
	# create a new tally counter for Mr. G
	var step_counter = TallyCounter.new()

	while get_item_name_before_me() != "Plant":
		if get_item_name_before_me() == "":
			step_forward()
			# now we need to count one step taken, so..
			step_counter.count()
			
		if get_item_name_before_me() == "Turn Left Sign":
			turn_left()
		
		if get_item_name_before_me() == "Turn Right Sign":
			turn_right()
	
	# finally at the end we should say how many steps it has taken,
	# so we read this from our tally counter.
	say("I have arrived and it took " + str(step_counter.current_count) + " steps!")


## Challenge 3

We have two ways in which we could solve this. The first would be to use two counters,
one for the total amount of steps and one for the steps since the last break. We again KEEP
the `get_item_name_before_me` function from challenge 1 and 2. 

func what_should_i_do():
	# This is the counter which we use to count our total steps
	var step_counter = TallyCounter.new()
	# This is a second counter which we use to count the steps
	# since the last break.
	var break_counter = TallyCounter.new()

	while get_item_name_before_me() != "Plant":
		if get_item_name_before_me() == "":
			step_forward()
			# now we need to count one step taken, so..
			step_counter.count()
			# we also count the break counter
			break_counter.count()
			# now if the break counter is showing 3
			# Mr. G will take a break
			if break_counter.current_count == 3:
				say("Taking a break.")
				# we also reset the break counter.
				break_counter.reset()
			
		if get_item_name_before_me() == "Turn Left Sign":
			turn_left()
		
		if get_item_name_before_me() == "Turn Right Sign":
			turn_right()
	
	# and we use the step counter to announce the total amount of steps.
	say("I have arrived and it took " + str(step_counter.current_count) + " steps!")


Another option to solve this problem would be to use some math instead of a second counter. With the 
`%` operator we can get the remainder of an integer division. So if the number on our step counter 
is divisible by 3 without a remaider (e.g. the remainder is zero) we know that we just have 
taken 3 steps in a row and need to take a break. 

func what_should_i_do():
	# This is the counter which we use to count our total steps
	var step_counter = TallyCounter.new()

	while get_item_name_before_me() != "Plant":
		if get_item_name_before_me() == "":
			step_forward()
			# now we need to count one step taken, so..
			step_counter.count()
			# We check if the step counter shows an exact multiple
			# of 3. We also need to check if the count is 
			# greater than 0 so we don't take a break right at
			# the beginning. We can use the `and` keyword to check
			# that both conditions are true at the same time:
			if step_counter.current_count % 3 == 0 and step_counter.current_count > 0:
				say("Taking a break.")
			
		if get_item_name_before_me() == "Turn Left Sign":
			turn_left()
		
		if get_item_name_before_me() == "Turn Right Sign":
			turn_right()
	
	# and we use the step counter to announce the total amount of steps.
	say("I have arrived and it took " + str(step_counter.current_count) + " steps!")
	
	
