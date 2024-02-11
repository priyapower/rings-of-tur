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


## CUSTOMIZABLE VARS
@export var current_state: State

## LOCAL VARS
var states: Dictionary = {}


## BEHAVIORS
## In `init`, we initialize each of our child states
## and connect this machine's signals to each child state.
## We also crete our states dictionary and start the 
## execution of the initial state
func init(parent: CharacterBody2D, animations: AnimationPlayer, move_component) -> void:
	for child in get_children():
		if child is State:
			## Set the entity as the parent variable reference in each child state
			child.parent = parent
			child.animations = animations
			child.move_component = move_component

			## Add the state to the `Dictionary` using its `name`
			states[child.name] = child

			## Connect the state machine to the `transitioned` signal of all children
			child.transitioned.connect(on_child_transitioned)

			## Add previous state as current state
			child.previous_state = current_state
		else:
			push_warning("State machine contains child which is not a 'State'")

	## Start execution of the initial state
	current_state.enter()


## `on_child_transitioned` will get the name of the next state
## and execute the transition from the current state (calling 
## `.exit`) to the new state (calling `.enter`)
func on_child_transitioned(new_state_name: StringName, child: State) -> void:
	# Get the next state from the `Dictionary`
	var new_state = states.get(new_state_name)
 
	if new_state != null:
		if new_state != current_state:
			## Exit the current state
			current_state.exit()

			## Update previous state
			child.previous_state = current_state

			## Enter the new state
			new_state.enter()
 
			## Update the current state to the new one
			current_state = new_state
	else:
		push_warning("Called transition on a state that does not exist")


## PASS PROCESSES THROUGH TO CURRENT STATE
## Responsible for calling `.process_input` for the current state
func process_input(event: InputEvent) -> void:
	current_state.process_input(event)


## Responsible for calling `.process_frame` for the current state
func process_frame(delta: float) -> void:
	current_state.process_frame(delta)


## Responsible for calling `.process_physics` for the current state
func process_physics(delta: float) -> void:
	current_state.process_physics(delta)
