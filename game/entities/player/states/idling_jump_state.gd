class_name IdlingJumpState
extends State
 
func enter() -> void:
	super()


func physics_update(_delta):
	var is_jump_just_pressed: bool = Input.is_action_just_pressed("jump")
	
	if is_jump_just_pressed:
		if parent.is_on_floor():
			transitioned.emit("JumpingJumpState", self)
		else:
			transitioned.emit("DoubleJumpingJumpState", self)
