extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var run_state: State

@export
var jump_force: float = 300.0

func enter() -> void:
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float) -> State:
	var movement = Input.get_axis('left', 'right') * move_speed
	
	if !parent.is_on_floor():
		parent.velocity.y += gravity * delta
		
		if parent.velocity.y > 0:
			return fall_state
		
		if movement != 0:
			if Input.is_action_pressed("left"):
				parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
			elif Input.is_action_pressed("right"):
				parent.sprite.scale.x = abs(parent.sprite.scale.x)
		parent.velocity.x = movement
		parent.move_and_slide()
	else:
		if movement != 0:
			return run_state
		return idle_state
	
	return null
