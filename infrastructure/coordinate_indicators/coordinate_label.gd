@tool
extends MarginContainer

@onready var _label:Label = %Label

var text:String:
	set(value):
		text = value
		if _label != null:
			_label.text = text
			
func _ready():
	_label.text = text
