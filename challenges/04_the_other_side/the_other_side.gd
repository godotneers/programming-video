extends SteppingRobot


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
