class_name IdlingFrogState
extends State


## BEHAVIORS
func enter() -> void:
	super()
	## Reset velocity when entering the state
	parent.velocity.x = 0


func process_physics(_delta) -> State:
	## Handle transitions
	if parent.chase:
		transitioned.emit("AttackingFrogState", self)
	if parent.dead:
		transitioned.emit("DyingFrogState", self)

	return null
