@tool
## This is the class that represents Mr.G. It provides all the functionality
## to control him.
class_name SteppingRobot
extends Node2D

signal step_started(index: int, max: int, step: RobotStep)
signal finished()

@warning_ignore("unused_private_class_variable")
@onready var _speech_bubble: SpeechBubble = %SpeechBubble
@warning_ignore("unused_private_class_variable")
@onready var _hand: Marker2D = %Hand
@onready var _world: TileMap = get_tree().get_nodes_in_group("world")[0] as TileMap

var _recorded_steps: Array[RobotStep] = []


## The coordinates where Mr. G is currently standing.
var coordinates: Vector2i:
	get: return Vector2i(roundi(global_position.x / 128), roundi(global_position.y / 128))

## The coordinates where Mr. G would be if he took a step forward.
var coordinates_before_me: Vector2i:
	get:
		var direction: Vector2              = Vector2.RIGHT.rotated(global_rotation)
		var direction_as_vector2i: Vector2i = Vector2i(roundi(direction.x), roundi(direction.y))
		return coordinates + direction_as_vector2i

## A list of all items that are right in front of Mr. G. Is empty if there are no items.
var all_items_before_me: Array[Item]:
	get:
		var result: Array[Item] = []
		var coords: Vector2i    = coordinates_before_me
		for item in get_tree().get_nodes_in_group("item"):
			if item.coordinates == coords:
				result.append(item)

		return result

## The item that Mr. G is currently holding in his hand. Is `null` if Mr. G is not holding anything.
var item_in_hand: Item = null

## Indicates if Mr. G is currently holding an item in his hand. Is `true` if Mr. G is holding an item and
## is `false` if Mr. G is not holding an item.
var i_have_an_item_in_hand: bool:
	get: return item_in_hand != null

## The item that is right in front of Mr. G. Is `null` if there is no item. If there are multiple items
## right in front of Mr. G, the first item is returned.
var item_before_me: Item:
	get:
		var all_items: Array[Item] = all_items_before_me
		if all_items.size() > 0:
			return all_items[0]
		return null

## Indicates if there is an item right in front of Mr. G. Is `true` if there is an item and is `false` if
## there is no item.
var is_item_before_me: bool:
	get:
		return item_before_me != null

## Indicates if Mr. G is currently facing a wall. Is `true` if Mr. G is facing a wall and is `false` if
## Mr. G is not facing a wall.
var i_am_facing_a_wall: bool:
	get: return _world.get_cell_tile_data(0, coordinates_before_me) == null

## Returns the color of the tile in front of Mr.G. Returns empty string when there is no tile before
## Mr. G.
var tile_color_before_me: StringName:
	get:
		var tile = _world.get_cell_tile_data(0, coordinates_before_me)
		if tile == null:
			return ""
		return tile.get_custom_data("tile_color")

## Returns the tile color of the tile under Mr.G.
var tile_color_under_me: StringName:
	get:
		var tile = _world.get_cell_tile_data(0, coordinates)
		if tile == null:
			return ""
		return tile.get_custom_data("tile_color")


func _record_step(step: RobotStep):
	if _recorded_steps.size() == 1000:
		push_error("Too many steps. Have you created an endless loop?")
		get_tree().quit()

	_recorded_steps.append(step)
	step.do()


func _reset_and_play():
	var to_reset: Array[RobotStep] = _recorded_steps.duplicate()
	to_reset.reverse()
	for step in to_reset:
		step.undo()

	for i in _recorded_steps.size():
		var step: RobotStep = _recorded_steps[i]
		step_started.emit(i, _recorded_steps.size(), step)
		await step.play()

	finished.emit()


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	# move to closest grid center
	global_position = coordinates * 128.0
	_what_should_i_do.call_deferred()


func _what_should_i_do():
	what_should_i_do()
	_reset_and_play()

## Mr. G's list of instructions. This function is automatically called by Mr. G when the game starts.
func what_should_i_do():
	pass

## Shows the given text in a speech bubble above Mr. G's head.
func say(what: Variant):
	_record_step(SayStep.new(self).setup(what))

## Turns Mr. G to the left.
func turn_left() -> void:
	_record_step(TurnLeftStep.new(self))

## Turns Mr. G to the right.
func turn_right() -> void:
	_record_step(TurnRightStep.new(self))

## Steps Mr. G one step forward into the direction he's currently looking. Will say a warning
## if Mr. G is on the edge of the room and cannot walk forward.
func step_forward() -> void:
	_record_step(StepForwardStep.new(self))

## Picks up the item that is right in front of Mr. G. Will say a warning if there is no item.
func pick_up_item() -> void:
	_record_step(PickupItemStep.new(self))

## Drops the item that Mr. G is currently holding in his hand. Will say a warning if Mr. G is not holding
## an item.
func drop_item() -> void:
	_record_step(DropItemStep.new(self))
