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


