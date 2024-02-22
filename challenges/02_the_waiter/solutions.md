# Solutions

This file contains some solutions for the challenges. Remember that there
is always more than one way to solve a problem, so if your solution looks
different than the one shown here this is totally fine - if your program solves
the problem it is a valid solution.

## Challenge 1

This problem is almost identical to the one we saw in the video. So a working solution would be:
	
func what_should_i_do():
	step_forward()
	pick_up_item()
	turn_left()
	turn_left()
	step_forward()
	drop_item()
	
## Challenge 2

A first solution would be to code the steps that we need to solve the problem and see if a pattern
emerges. So lets start with:
	
func what_should_i_do():
	# pick up and drop the first cup
	step_forward()
	pick_up_item()
	turn_left()
	turn_left()
	step_forward()
	drop_item()
	# turn around 
	turn_left()
	turn_left()
	step_forward()
	# we are now at the first pink field
	# turn right so we can step down
	turn_right()
	step_forward()
	step_forward()
	turn_left()
	# now we are facing the second cup
	# so we can repeat the steps from the first cup
	pick_up_item()
	turn_left()
	turn_left()
	step_forward()
	drop_item()
	
	
Now we want to update this so it works no matter where we place the cups and  mo many cups we 
place. We can solve this by first going to the pink side. Then we check if there is a cup there. 
If there is, we bring the cup to blue side and come back to the pink side. Now we turn right,
move one step down and repeat what we just did for the remaining fields:
	

func what_should_i_do():
	# Move right, one step
	step_forward()
	# repeat these 4 times
	for step:int in 4:
		# check if we have a coffee cup.
		if is_item_before_me:
			# if we have, pick it up, turn around, bring it over
			# and come back. We put this into a separate function
			# just to have this a bit more organized.
			deliver_cup()
		# now we have either just delivered a cup and are back
		# or there was no cup to begin with. in any case we are
		# now standing at the pink side and look at an empty tile.
		# so we can go down to the next row.
		turn_right()
		step_forward()
		# and turn left again so we face the pink side again
		turn_left()
	
# Helper function. This delivers a cup of coffee from the pink to the 
# blue side. Assumes that there actually is a cup.	
func deliver_cup():
	pick_up_item()
	# we make a turn_around function here as this is quite useful to have
	turn_around()
	step_forward()
	drop_item()
	turn_around()
	step_forward()
	
# Helper function. Turns Mr. by 180 degrees relative to the direction he is
# currently looking.
func turn_around():
	turn_left()
	turn_left()
	
	
## Challenge 3

We can reuse most of the program that we already have from the second challenge. We will
need to add a variable to track how many coffees we have delivered.


func what_should_i_do():
	# we start with zero coffees delivered
	var coffees_delivered:int = 0

	step_forward()
	for step:int in 4:
		if is_item_before_me:
			# if we have a coffee, deliver it and then increase
			# the amount of delivered coffees
			deliver_cup()
			coffees_delivered += 1
		# the rest is just like in the previous challenge
		turn_right()
		step_forward()
		turn_left()
		
	# finally we want to calculate the money Mr.G has earned. We get two
	# coins per delivered coffee so:
	
	var coins_earned:int = 2 * coffees_delivered
	
	# now for the bonus.. If we have delivered 3 or more coffees
	if coffees_delivered >= 3:
		# we get a bonus of 2 coins
		coins_earned += 2
		
	# Finally let Mr. G. say how many coins he has earned:
	say("I have earned " + str(coins_earned) + " coins.")
		
# the deliver_cup and turn_around functions stay the same as they were in the previous challenge 
