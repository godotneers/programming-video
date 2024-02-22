@tool
extends MarginContainer

@export var grid_size:Vector2i = Vector2i(2,2):
	set(value):
		grid_size = value
		_repaint()
		
@export var grid_offset:Vector2i = Vector2i(0,0):
	set(value):
		grid_offset = value
		_repaint()

@onready var _grid_container:GridContainer = %GridContainer

const _label_scene:PackedScene = preload("coordinate_label.tscn")

func _ready():
	_repaint()
	
func _repaint():
	if _grid_container == null:
		return
	
	global_position = Vector2(grid_offset * 128.0) - Vector2(64, 64)
	
	for child in _grid_container.get_children():
		_grid_container.remove_child(child)
		child.queue_free()
	
	_grid_container.columns = grid_size.x
	for y in grid_size.y:
		for x in grid_size.x:
			var label = _label_scene.instantiate()
			label.text = "%s, %s" % [x + grid_offset.x, y + grid_offset.y]
			_grid_container.add_child(label)
			

