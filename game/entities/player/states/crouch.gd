# Crouching state
extends State

# Update input mapping for crouch
	# key: Down
	# key: S

# [External files] States that transition to crouch
	# These scripts need update (if on_floor && input == crouch: run_crouch)
		# Idle --> crouch
		# Run --> crouch
		# Fall --> crouch

# States that this script handles (transtions from crouch)
	# crouch --> Idle
	# crouch --> Run
	# crouch --> Jump
@export var idle_state: State
@export var run_state: State
@export var jump_state: State


func process_input(event: InputEvent) -> State:
	# Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null

func process_physics(delta: float) -> State:
	print("CROUCH", delta)
	# Gravity?
	# Handles horizontal movement
	# Speed shouldn't be the same as run speed - update exported var for this Node!
	return null
