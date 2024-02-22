@tool
class_name SpeechBubble
extends Node2D

@onready var _label:Label = %Label
@onready var _bubble:MarginContainer = %SpeechBubble

func _ready():
	#if not Engine.is_editor_hint():
	modulate = Color.TRANSPARENT

func _process(_delta):
	_bubble.position = Vector2(-_bubble.get_rect().size.x / 2,  -_bubble.get_rect().size.y)

func say(text:String, duration:float = 2.0) -> void:
	_label.text = text
	
	var tween:Tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	await tween.finished
	
	await get_tree().create_timer(duration).timeout
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.3)
	await tween.finished
