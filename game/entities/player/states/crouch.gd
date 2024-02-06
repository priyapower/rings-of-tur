# Crouching state
extends State

## States ##
@export var idle_state: State

## Crouching variables ##
var down_released

func enter() -> void:
	super()
	down_released = false

func process_input(event: InputEvent) -> State:
	# Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null

func process_physics(delta: float) -> State:
	# Handle press and hold/release for crouch behavior
	if Input.is_action_just_released("down"):
		down_released = true
		
	var horizontal_direction = Input.get_axis('left', 'right')
	
	# Add the gravity
	parent.velocity.y += gravity * delta
	
	# Handle crouch
	if horizontal_direction != 0:
		parent.velocity.x = horizontal_direction * run_speed
		parent.move_and_slide()

	# Handle state transition
	if !parent.ray_cast.is_colliding() && down_released:
		return idle_state
	return null
