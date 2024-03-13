extends SteppingRobot

var my_tally_counter:TallyCounter = TallyCounter.new()

func what_should_i_do():
	var item_names:Array = []
	
	
	for step:int in 3:
		
		step_forward()
		turn_left()
		if item_before_me != null:
			item_names.append(item_before_me.item_name)
		
		turn_right()
		
	for name:String in item_names:
		say(name)
