@tool
class_name Item
extends Node2D

@onready var sprite_2d: Sprite2D = %Sprite2D


@export var item_name:String
@export var texture:Texture2D:
	set(value): 
		texture = value
		_refresh()
		
		
var coordinates:Vector2i:
	get: return Vector2i(roundi(global_position.x / 128), roundi(global_position.y / 128))
	
	
		
func _ready():
	# move to closest grid center
	if not Engine.is_editor_hint():
		global_position = coordinates * 128.0
	_refresh()
	
	
func _refresh():
	if sprite_2d != null:
		sprite_2d.texture = texture		 
	


