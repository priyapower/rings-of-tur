extends CharacterBody2D
class_name PersistentState


var state
var state_factory
var jump_height = Vector2()


func _ready():
	state_factory = StateFactory.new()
	change_state("idle")


func _process(_delta):
	if Input.is_action_pressed("left"):
		move_left()
	elif Input.is_action_pressed("right"):
		move_right()


func move_left():
	state.move_left()


func move_right():
	state.move_right()


func change_state(updated_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(updated_state_name).new()
	var change_state_function = Callable(self, "change_state")
	state.setup(change_state_function, $AnimationPlayer, $Sprite2D, self)
	state.name = "current_state"
	add_child(state)
