## This represents an item that can be placed in the room.
@tool
class_name Item
extends Node2D

@onready var sprite_2d: Sprite2D = %Sprite2D

## The name of the item.
@export var item_name:String

## An image representing the item.
@export var texture:Texture2D:
	set(value): 
		texture = value
		_refresh()
		
## The grid coordinates where the item currently is located.		
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
	


