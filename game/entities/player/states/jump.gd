# Jumping state
extends State

## States ##
@export var fall_state: State
@export var idle_state: State
@export var run_state: State

## Jump variables ##
@export var jump_force: float = 400.0

func enter() -> void:
	super()
	parent.velocity.y = -jump_force

func process_input(event: InputEvent) -> State:
	# Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null

func process_physics(delta: float) -> State:
	var horizontal_direction = Input.get_axis('left', 'right')
	var no_vertical_movement = parent.velocity.y == 0
	
	# Add the gravity
	parent.velocity.y += gravity * delta
	
	# Handle jump
	parent.move_and_slide()
	
	# Handle state transitions
	if parent.is_on_floor():
		if no_vertical_movement && horizontal_direction == 0:
			return idle_state
		#if no_vertical_movement && horizontal_direction != 0 && (Input.is_action_just_pressed('left') || Input.is_action_just_pressed('right')):
		if no_vertical_movement && (Input.is_action_just_pressed('left') || Input.is_action_just_pressed('right')):
			return run_state
	else:
		if (parent.velocity.y > 0) && !parent.is_on_ceiling():
			return fall_state
	
	return null
