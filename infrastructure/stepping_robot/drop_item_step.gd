class_name DropItemStep
extends RobotStep

var _hands_were_empty: bool = false


func do() -> void:
	if _owner.item_in_hand == null:
		_hands_were_empty = true
		return

	if _owner.i_am_facing_a_wall:
		return

	var item: Item = _owner.item_in_hand
	_owner.item_in_hand = null
	_move_node(item, _owner.get_parent())
	item.add_to_group("items")


func undo() -> void:
	if _hands_were_empty or _owner.i_am_facing_a_wall:
		return

	var item: Item = _owner.item_before_me
	_owner.item_in_hand = item
	_move_node(item, _owner._hand)
	item.remove_from_group("items")


func play() -> void:
	if _owner.item_in_hand == null:
		await _owner._speech_bubble.say("I have nothing in my hand!")
		return

	if _owner.i_am_facing_a_wall:
		await _owner._speech_bubble.say("I am at a wall, I can't drop the item")
		return

	var item: Item               = _owner.item_in_hand
	var target_position: Vector2 = _owner.coordinates_before_me *128.0
	var tween: Tween             = _owner.create_tween()
	tween.tween_property(item, "global_position", target_position, 0.5)
	tween.parallel().tween_property(item, "scale", Vector2(1, 1), 0.5)
	await tween.finished

	_move_node(item, _owner.get_parent())
	item.add_to_group("items")
	_owner.item_in_hand = null


func describe() -> String:
	return "Drop the item in my hand before me"
