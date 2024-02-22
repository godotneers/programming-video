@tool
extends PanelContainer

@onready var _label:RichTextLabel = %Label

@export_multiline var text:String:
	set(value):
		text = value
		_refresh()

func _ready():
	_refresh()
	
func _refresh():
	if _label == null:
		return
		
	_label.text = _richtextify(text)
	
func _richtextify(input:String) -> String:
	# replace backticks with code tags.
	var result = input
	var backticks = RegEx.new()
	backticks.compile("`(.*?)`")
	result = backticks.sub(input, "[code]$1[/code]", true)	
	return result


