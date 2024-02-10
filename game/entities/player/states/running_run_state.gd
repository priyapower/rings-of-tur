class_name RunningRunState
extends State


## BEHAVIORS
func process_input(event: InputEvent) -> State:
	## Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null


func process_physics(delta) -> State:
	## Capture horizontal axis integer
	var horizontal_direction: float = move_component.get_horizontal_movement()

	## Add gravity and movement
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	## Handle horizontal velocity
	if horizontal_direction != 0:
		parent.velocity.x = horizontal_direction * run_speed

	## Handle slowing down after releasing input
	if horizontal_direction == 0:
		parent.velocity.x = lerp(parent.velocity.x, 0.0, 0.8)

	## Handle transitions
	if parent.velocity.x == 0:
		transitioned.emit("IdlingRunState", self)

	return null
