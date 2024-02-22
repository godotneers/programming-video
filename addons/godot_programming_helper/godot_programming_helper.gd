@tool
extends EditorPlugin


var switcher:Control

func _enter_tree():
	switcher = preload("challenge_switcher.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_SIDE_LEFT, switcher)
	scene_changed.connect(_on_scene_changed)


func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_SIDE_LEFT, switcher)
	scene_changed.disconnect(_on_scene_changed)
	

func _on_scene_changed(root:Node):
	if not is_instance_valid(switcher):
		return
		
	switcher.scene_changed(root)
