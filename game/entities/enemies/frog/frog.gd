class_name Frog
extends CharacterBody2D


@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var frog_state_machine = $FrogStateMachine
@onready var move_component = $FrogMove
#@onready var chase: bool = false
#@onready var dead: bool = false
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase: bool = false
var dead: bool = false


func _ready():
	frog_state_machine.init(self, animations, move_component)


## PASS PROCESSES THROUGH TO STATE MACHINE
func _process(delta: float) -> void:
	frog_state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	## Add gravity and movement
	velocity.y += gravity * delta
	move_and_slide()
	frog_state_machine.process_physics(delta)


### If player enters detection range
#func _on_player_detection_body_entered(body):
	#print("body entered")
	##print("body.is_in_group('Playable'): ", body.is_in_group("Playable"))
	##print("dead:" , dead)
	##print("chase: ", chase)
	#if body.is_in_group("Playable") and !dead and !chase:
		##print("CHASE CONDITION")
		#move_component.playable_body = body
		#chase = true
#
#
### If player exits detection range
#func _on_player_detection_body_exited(body):
	#print("body exited")
	#if body.is_in_group("Playable") and !dead:
		##print("------ exit chase condition-------")
		#chase = false




### If sprite hurts player
#func _on_hurt_player_body_entered(body):
	#if body.is_in_group("Playable"):
		#pass
		## Reduce player's health on collision
		##body.health -= 1
		##body.render_hit()
		##Game.hp -= 1
#
#
### If player kills sprite by jump
#func _on_death_by_jump_body_entered(body):
	#if body.is_in_group("Playable") and !dead:
		### Stop chasing
		#chase = false
#
		 ### Set for death sequence
		#dead = true
#
#
#
#func _on_player_detection_body_entered(body):
	#print("body: ", body)
	#if body.is_in_group("Playable"):
		#print("body entered")
#
#
#
#
#func _on_player_detection_body_exited(body):
	#print("body: ", body)
	#if body.is_in_group("Playable"):
		#print("body exited")
		



func _on_playable_detection_body_entered(body):
	if body.is_in_group("Playable"):
		print("///enter signal///")
		print("chase: ", chase)
		chase = true


func _on_playable_detection_body_exited(body):
	if body.is_in_group("Playable"):
		print("---exit signal----")
		print("chase: ", chase)
		chase = false
