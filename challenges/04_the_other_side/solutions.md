# Solutions

This file contains some solutions for the challenges. Remember that there
is always more than one way to solve a problem, so if your solution looks
different than the one shown here this is totally fine - if your program solves
the problem it is a valid solution.

## Challenge 1

We can use the the `tile_color_under_me` property to find out whether we are still standing
on a yellow tile. We use the `tile_color_before_me` to get the color of the tile before Mr. G. 
The rest is very similar to what we did in the video:

func what_should_i_do():
	# We remember the color names in this array
	var colors:Array = []
	
	# step one step forward so we land at the first tile
	step_forward()

	# now we want to repeat steps based on a condition, so 
	# a while loop can work here. We could also count the tiles
	# and do a for step:int in 3 loop. There is always more than
	# one way to do it.
	while tile_color_under_me == "yellow":
		turn_left()
		# we look at the tile before Mr. G and append its color 
		# to the array
		colors.append(tile_color_before_me)
		turn_right()
		step_forward()
		
	# finally we say all the colors
	for color in colors:
		say(color)

	# Now for the bonus challenge
	say("Bonus challenge")
	
	# for the bonus challenge we also have options
	
	# Uncomment the code to try out each option.
	
	# Option 1: Array has a reverse function, which reverses the order of items in the array. 
	#
	#colors.reverse()
	#for color in colors:
	#	say(color)
	
	# Option 2: We can use the for loop with an index variable and use math to calculate the indices
	# in reverse order. 
	#
	# This will run a loop with our index variable having the values 0, 1 and 2
	#for index:int in colors.size():
	#	# now we can calculate the index to get from our array. We use (colors.size() - 1) - index
	#	# to get the indices in reverse order. colors.size() is 3 and is not changing while the
	#	# loop is repeating, so (colors.size() - 1) will always be 2 during the loop. 
	#	# 1st loop: 2 - index = 2 - 0 = 2
	#	# 2nd loop: 2 - index = 2 - 1 = 1
	#	# 3rd loop: 2 - index = 2 - 2 = 0
	#	say(colors[(colors.size() - 1) - index ]) 
	
	
## Challenge 2

We need to remember the tile color for each item. A dictionary can be very helpful for that. We
add an entry for each item that we see and use the item's name as a key and the color of the tile
the item is standing on as a value. At the end we use the dictionary's keys() method to get the keys
of all entries we have stored in it, so we can prepare the sentences that Mr. G should say.

func what_should_i_do():
	# We remember pairs of item names and colors in this dictionary. 
	# The key is the item name, the value is the tile color.
	var pairs:Dictionary = {}
	
	# step one step forward so we land at the first tile
	step_forward()

	# similar to the previous challenge, we repeat these steps until
	# Mr. G arrives at a yellow tile.
	while tile_color_under_me == "yellow":
		turn_left()
		# the item before Mr. G may be absent so we need to check for null
		if item_before_me != null:
			# store the tile color under the item's name. e.g.
			# plant -> blue
			pairs[item_before_me.item_name] = tile_color_before_me
		turn_right()
		step_forward()

	# we now need to know what is inside of our dictionary. we can use the
	# keys() method to get all the keys that are currently in the dictionary.
	# then we can use a for loop to let Mr. G say something for every key in
	# our dictionary.
	
	for item_name in pairs.keys():
		# get the tile color for this item back
		var color = pairs[item_name]
		# and let Mr. G say it
		say("The " + item_name + " is on a " + color + " tile.")
	

## Challenge 3

This is another variation of the second challenge, but this time we need to think about which
information we use as key and which one we use as value in our dictionary. Usually you put the
information you have as a key and the information you want to look up as the value. In our case
we have a tile color and want to look up an item name, so we put the tile color as key and the 
item name as value:
	
func what_should_i_do():
	# Like in challenge 2 we use a dictionary to remember which item
	# was on which tile. But this time, we use the tile color as key
	# and the item name as value.
	var pairs:Dictionary = {}
	
	# step one step forward so we land at the first tile
	step_forward()

	# similar to the previous challenge, we repeat these steps until
	# Mr. G arrives at a yellow tile.
	while tile_color_under_me == "yellow":
		turn_left()
		# the item before Mr. G may be absent so we need to check for null
		if item_before_me != null:
			# now store the item name under the tile's color
			# blue -> plant
			pairs[tile_color_before_me] = item_before_me.item_name
		turn_right()
		step_forward()

	# we have now entered the the right side and need to run another loop.
	# this time we check that the tile color before Mr. G is orange which will
	# be false once he arrives at the right edge of the room.
	while tile_color_before_me == "orange":
		turn_left()
		# now tile_color_before_me has the color we need to look up in our
		# dictionary. However we need to handle the case that no item was
		# on the tile with this color on the left hand side. We can
		# use the dictionary's "has" method, to see if it has an entry for
		# the tile we're currently looking at:
		if pairs.has(tile_color_before_me):
			say("There was a " + pairs[tile_color_before_me] + " on the " + tile_color_before_me + " tile.")
		else:
			say("There was nothing on the " + tile_color_before_me + " tile.")

		# finally turn right again and walk to the next tile.
		turn_right()
		step_forward()	
