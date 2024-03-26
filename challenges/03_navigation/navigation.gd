extends SteppingRobot

func what_should_i_do():
	while is_item_before_me == false:
		step_forward()
