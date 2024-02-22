class_name PickupItemStep
extends RobotStep

var _hands_were_full:bool = false

func do() -> void:
	if _owner.item_in_hand != null:
		_hands_were_full = true
		return
		
	var item: Item = _owner.item_before_me
	if item != null:
		_owner.item_in_hand = item
		_move_node(item, _owner._hand)
		item.remove_from_group("items")
	   
func undo() -> void:
	if _hands_were_full:
		return
		
	if _owner.item_in_hand == null:
		return
		
	var item: Item = _owner.item_in_hand
	_move_node(item, _owner.get_parent())
	item.add_to_group("items")
		

func play() -> void:
	if _owner.item_before_me == null:
		await _owner._speech_bubble.say("There is nothing I can pick up in front of me.")
		return 
		
	if _hands_were_full:
		await _owner._speech_bubble.say("My hand is full!")
		return

	var item: Item  = _owner.item_before_me	
	var tween:Tween = _owner.create_tween()
	tween.tween_property(item, "global_position", _owner._hand.global_position, 0.5)
	tween.parallel().tween_property(item, "scale", Vector2(0.4, 0.4), 0.5)
	await tween.finished

	_owner.item_in_hand = item
	_move_node(item, _owner._hand)
	item.remove_from_group("items")
	
	
func describe() -> String:
	return "Pick up the item before me"
