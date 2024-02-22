class_name StepForwardStep
extends RobotStep

var _stepped: bool = true


func _get_forward_vector() -> Vector2:
	return Vector2.RIGHT.rotated(_owner.global_rotation)


func do():
	if not _owner.i_am_facing_a_wall:
		_owner.global_position += 128.0 * _get_forward_vector()
	else:
		_stepped = false


func undo():
	if _stepped:
		_owner.global_position -= 128.0 * _get_forward_vector()


func play() -> void:
	if not _stepped:
		await _owner._speech_bubble.say("Can't walk forward anymore")
		return

	var tween: Tween = _owner.create_tween()
	tween.tween_property(_owner, "global_position", _owner.global_position + 128.0 * _get_forward_vector(), 1.0)
	await tween.finished
	
	
func describe() -> String:
	return "Step forward"
