class_name TurnLeftStep
extends RobotStep

func do():
	_owner.rotation -= PI / 2.0


func undo():
	_owner.rotation += PI / 2.0


func play():
	var tween: Tween = _owner.create_tween()
	tween.tween_property(_owner, "rotation", _owner.rotation - PI / 2.0, 0.3)
	await tween.finished

	
func describe() -> String:
	return "Turn left"
