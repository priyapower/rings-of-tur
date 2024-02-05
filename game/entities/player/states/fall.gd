extends State

@export
var idle_state: State
@export
var run_state: State

func process_physics(delta: float) -> State:
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if !parent.is_on_floor():
		parent.velocity.y += gravity * delta

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
