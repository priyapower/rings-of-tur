extends Node
class_name State


## Variables ##
# Learning note: Godot 3 syntax
# var state = null setget set_state
# Learning note: Godot 4 syntax
var state = null : set = set_state
var previous_state = null
var states : Dictionary = {}



@onready var parent = get_parent()


## Functions ##
func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			set_state(transition)


func _state_logic(delta):
	pass


func _get_transition(delta):
	return null


func _enter_state(new_state, old_state):
	pass


func _exit_state(old_state, new_state):
	pass


func set_state(new_state):
	previous_state = state
	state = new_state
	
	if previous_state != null:
		_exit_state(previous_state, new_state)
	
	if new_state != null:
		_enter_state(new_state, previous_state)


func add_state(state_name):
	state[state_name] = states.size()
