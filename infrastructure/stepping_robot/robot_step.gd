class_name RobotStep

var _owner: SteppingRobot


func _init(owner: SteppingRobot):
	_owner = owner


func do():
	pass


func undo():
	pass


func play():
	pass


func _move_node(node: Node2D, to: Node2D):
	var global_pos: Vector2 = node.global_position
	node.get_parent().remove_child(node)
	to.add_child(node)
	node.global_position = global_pos


func describe() -> String:
	return "Description missing!"
