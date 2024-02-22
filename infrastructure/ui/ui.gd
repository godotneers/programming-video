extends PanelContainer

@onready var label:Label = %Label

func on_step_started(index:int, max_steps:int, step:RobotStep):
	label.text = "Step %s of %s: %s " % [index+1, max_steps, step.describe()]
	
func on_robot_finished():
	label.text = "All done."
