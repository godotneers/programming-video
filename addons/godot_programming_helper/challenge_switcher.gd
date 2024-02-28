@tool
extends MarginContainer

var _challenges:Array[Node] = []
@onready var _root:Container = %VBoxContainer 

func scene_changed(new_root:Node):
	if not is_instance_valid(new_root):
		_challenges.clear()
	else:
		_challenges = new_root.get_tree().get_nodes_in_group("challenge")
	_refresh_ui()
	
func _refresh_ui():
	if _challenges.is_empty():
		visible = false
		return
	
	for child in _root.get_children():
		if child is Button:
			_root.remove_child(child)
			child.queue_free()
	
	for challenge in _challenges:
		var button = Button.new()
		button.pressed.connect(_on_challenge_activated.bind(challenge))
		button.text = challenge.name
		_root.add_child(button)
		
	var hide_button = Button.new()
	hide_button.text  = "Hide Challenges"
	hide_button.pressed.connect(_on_hide_challenges)
	_root.add_child(hide_button)
		
	visible = true
		
func _on_challenge_activated(challenge:Node):
	_on_hide_challenges()
	challenge.visible = true	
		
func _on_hide_challenges():
	for other in _challenges:
		other.visible = false
