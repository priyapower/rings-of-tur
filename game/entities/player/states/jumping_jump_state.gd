class_name JumpingJumpState
extends State
 
@export var jump_velocity: int = -350
 
func Enter():
	## Apply velocity to jump only once when entering the state
	parent.velocity.y = jump_velocity
		
func Physics_update(_delta):
	var is_jump_just_pressed: bool = Input.is_action_just_pressed("up")
 
	if is_jump_just_pressed and parent.velocity.y > jump_velocity:
		transitioned.emit("DoubleJumpingJumpState", self)
		
	if parent.is_on_floor():
		transitioned.emit("IdleJumpState", self)
