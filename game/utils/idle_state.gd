extends State
class_name IdleState


"""
Since RunState and IdleState extend from State which extends Node2D, 
the function _physics_process(delta) is called from the bottom-up.
Meaning Run and Idle will call their implementation of 
_physics_process(delta), then State will call its implementation, 
then Node2D will call its own implementation and so on. 
This may seem strange, but it is only relevant for predefined 
functions such as _ready(), _process(delta), etc. Custom functions 
use the normal inheritance rules of overriding the base implementation.
"""
func _ready():
	animation.play("Idle")


func _flip_direction():
	sprite.scale.x = sprite.scale.x * -1
	# facing right scale.x = 1
	# facing left scale.x = -1


func move_left():
	#if sprite.scale.x == 1:
	if sprite.flip_h:
		change_state.call("run")
	else:
		_flip_direction()


func move_right():
	#if sprite.scale.x == -1:
	if not sprite.flip_h:
		change_state.call("run")
	else:
		_flip_direction()
