extends State
class_name RunState


## Constants ##
const SPEED = 200.0


## Variables ##
var move_speed = Vector2(180, 0)
var min_move_speed = 0.005
var friction = 0.32


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
	animation.play("Run")
	#if sprite.flip_h:
		#move_speed.x *= -1
	#persistent_state.jump_height += move_speed


func _physics_process(_delta):
	if persistent_state.velocity.x == 0:
		change_state.call("idle")
	
	#persistent_state.jump_height.x *= friction


func move_left():
	print("outside left", persistent_state.velocity.x)
	if sprite.scale.x == -1:
		#persistent_state.jump_height += move_speed
		print("RUN LEFT")
		print("inside", persistent_state.velocity.x)
		print("speed", SPEED)
		print(-1 * SPEED)
		persistent_state.velocity.x = -1 * SPEED
	else:
		change_state.call("idle")


func move_right():
	print("outside right", persistent_state.velocity.x)
	if sprite.scale.x == 1:
		#persistent_state.jump_height += move_speed
		print("RUN RIGHT")
		print("inside", persistent_state.velocity.x)
		print("speed", SPEED)
		persistent_state.velocity.x = SPEED
	else:
		change_state.call("idle")
