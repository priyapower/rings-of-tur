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
		# !horizontal_direction &&&&&& input up/jump
		# RENAME mapping from "jump" to "up" because this is now: exit_crouch, jump, and climb
	# crouch --> Run
		# WAIT - if down triggers crouch animation and then left right triggers movement when in crouch, we can't transition to run
	# crouch --> Jump
		# Same as above... the only transition state from crouch is Idle and this is triggered by "up"
@export var idle_state: State
#@export var run_state: State
#@export var jump_state: State


func process_input(event: InputEvent) -> State:
	# Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null

func process_physics(delta: float) -> State:
	print("CROUCH", delta)
	var horizontal_direction = Input.get_axis('left', 'right')
	var no_vertical_movement = parent.velocity.y == 0
	
	# Add the gravity
	parent.velocity.y += gravity * delta
	
	# Handle crouch
	if horizontal_direction != 0:
		parent.velocity.x = horizontal_direction * run_speed
		parent.move_and_slide()
	
	# Handle state transitions
	# WE NEED A CONDITION TO CHECK NO CEILING
	#if (no_vertical_movement && horizontal_direction == 0 && Input.is_action_just_pressed == "up"):
		#move_toward(parent.velocity.x, 0, run_speed)
		#return idle_state
	#if Input.is_action_just_pressed('jump'):
		#return jump_state
	#if !parent.is_on_floor() && parent.velocity.y > 0:
		#return run_state
	return null
