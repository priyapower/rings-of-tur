class_name StateMachine
extends Node
################################
##### FINITE STATE MACHINE #####
################################
##
## This script (utils/state_machine.gd) should be attached to a Node.
## This script will be shared by all the state machines in the project
## It will:
## - Store and execute the current_state by calling .update and .physics_update
## - Switch between states by calling .enter() and .exit() 
##   when a transitioned signal is emitted
## It uses:
## - `current_state` which represents the current state. 
##   It uses @export to assign the initial state from the editor
## - `states` is a Dictionary containing all the child 
##   nodes (states) indexed by their name
##
## USAGE:
## Each child of this node represents a possible state of the machine
## - The parent Node has this state_machine.gd script attached,
##   which is responsible to manage the current state and 
##   switch between states
## - Each child Node has a script that extends State and implements
##   the logic of the state it represents
##
## Example:
## - Let's take a Player scene as an example
## - Player scene has a Node called JumpStateMachine
## - JumpStateMachine has state_machine.gd script attached
##     - That is _this_ script file
## - JumpStateMachine has a child Node called JumpingJumpState
## - JumpingJumpState has a new script attached called jumping_jump_state.gd
##     - jumping_jump_state.gd must `extends State`


### CUSTOMIZABLE VARS
#@export var starting_state: State
#
### LOCAL VARS
#var previous_state: State
#var current_state: State
#
#
## Initialize the state machine by giving each child state a reference to the
## parent object it belongs to and enter the default starting_state.
#func init(parent) -> void:
	#for child in get_children():
		#child.parent = parent
#
	## Initialize to the default state
	#change_state(starting_state)
#
## Change to the new state by first calling any exit logic on the current state.
#func change_state(new_state: State) -> void:
	#print("IN CHANGE STATE")
	#print("new_state: ", new_state)
	#print("current_state: ", current_state)
	#print("previous_state: ", previous_state)
	#if current_state:
		#current_state.exit()
	#
	#previous_state = current_state
	#current_state = new_state
	#current_state.enter()
	#
## Pass through functions for the Player to call,
## handling state changes as needed.
#func process_physics(delta: float) -> void:
	#var new_state = current_state.process_physics(delta)
	#if new_state:
		#change_state(new_state)
#
#func process_input(event: InputEvent) -> void:
	#var new_state = current_state.process_input(event)
	#if new_state:
		#change_state(new_state)
#
#func process_frame(delta: float) -> void:
	#var new_state = current_state.process_frame(delta)
	#if new_state:
		#change_state(new_state)



### CUSTOMIZABLE VARS
@export var current_state: State

### LOCAL VARS
var states: Dictionary = {}
#var parent = get_parent()


### With `init` we can initialize this State Machine
func init(parent) -> void:
	# DEBUG ONLY
	print("JumpStateMachine init")
	print("JumpStateMachine parent: ", parent)
	print("JumpStateMachine current_state: ", current_state)

	for child in get_children():
		if child is State:
			print("JumpStateMachine child: ", child)
			# Set the entity as the parent variable reference in each child state
			child.parent = parent
			print("JumpStateMachine child.parent: ", child.parent)
			
			# Add the state to the `Dictionary` using its `name`
			states[child.name] = child
			
			# Connect the state machine to the `transitioned` signal of all children
			child.transitioned.connect(on_child_transitioned)
			
			# Add previous state as current state
			child.previous_state = current_state
			print("JumpStateMachine child.previous_state: ", child.previous_state)
			
		else:
			push_warning("State machine contains child which is not a 'State'")
	
	# DEBUG ONLY
	print("JumpStateMachine states: ", states)
	
	# Start execution of the initial state
	current_state.enter()
	


### In `_ready`, we initialize states, we connect
### the machine to each transitioned signal, and we 
### start the execution of the initial state
#func _ready():
	## DEBUG ONLY
	#print("JumpStateMachine _ready")
	#print("JumpStateMachine parent: ", parent)
#
	#for child in get_children():
		#if child is State:
			## Set the entity as the parent variable reference in each child state
			#child.parent = parent
			#
			## Add the state to the `Dictionary` using its `name`
			#states[child.name] = child
			#
			## Connect the state machine to the `transitioned` signal of all children
			#child.transitioned.connect(on_child_transitioned)
			#
			## Add previous state as current state
			#child.previous_state = current_state
			#
			## Start execution of the initial state
			#current_state.enter()
		#else:
			#push_warning("State machine contains child which is not a 'State'")
	#
	## DEBUG ONLY
	#print("JumpStateMachine states: ", states)


## `on_child_transitioned` will get the name of the next state
## and execute the transition from the current state (calling 
## `.exit`) to the new state (calling `.enter`)
func on_child_transitioned(new_state_name: StringName, child: State) -> void:
	print("STATE (on transition) new_state_name: ", new_state_name)
	print("STATE (on transition) child: ", child)
	print("STATE (on transition) current_state: ", current_state)
	
	# Get the next state from the `Dictionary`
	var new_state = states.get(new_state_name)
 
	if new_state != null:
		if new_state != current_state:
			# Exit the current state
			current_state.exit()

			# Update previous state
			child.previous_state = current_state

			# Enter the new state
			new_state.enter()
 
			# Update the current state to the new one
			current_state = new_state
	else:
		push_warning("Called transition on a state that does not exist")


## Responsible for calling `.update` for the current state
func _process(delta):
	current_state.update(delta)


## Responsible for calling `.physics_update` for the current state
func _physics_process(delta):
	current_state.physics_update(delta)
