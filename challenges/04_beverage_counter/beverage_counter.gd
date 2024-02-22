extends SteppingRobot

# Challenge: count how many teas and coffees are along the way
func what_should_i_do():
	var coffees:int = 0
	var teas:int = 0
	
	while not i_am_facing_a_wall:
		turn_right()
		if is_item_before_me:
			if item_before_me.item_name == "Coffee":
				coffees += 1
			if item_before_me.item_name == "Tea":
				teas += 1
				
		turn_left()
		step_forward()

	say("I got " + str(coffees) + " coffees and " + str(teas) + " teas.")
