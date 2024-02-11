## TODO: [DEBUG] _on_playable_detection_body_exited is continuously
## catching immediately after a playable body is detected entering 
## the Area2D node: PlayableDetection
##
## Why is this a problem:
## - The enemy animation is buggy because of this
## - It restarts the "Attack" animation because it keeps 
## flipping between chase = true and chase = false
##
## Recreation steps:
## - add a print statement in each if clause of the signals for
##   `on_playable_detection_body_<...>`
## - Play scene and run player into enemy detection collision layer
## - Print will signal "entry, exit, entry"
class_name Frog
extends CharacterBody2D


@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var frog_state_machine = $FrogStateMachine
@onready var move_component = $FrogMove
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var timer: Timer = Timer.new()
var chase: bool = false
var dead: bool = false
var playable_body: CharacterBody2D


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


## Playable entity enters detection range
func _on_playable_detection_body_entered(body):
	if body.is_in_group("Playable"):
		print("enter")
		playable_body = body
		chase = true


## Playable entity exits detection range
func _on_playable_detection_body_exited(body):
	if body.is_in_group("Playable"):
		print("exit")
		chase = false


## If player kills sprite by jump
func _on_kill_zone_body_entered(body):
	if body.is_in_group("Playable") and !dead:
		## Stop chasing
		chase = false

		 ## Set for death sequence
		dead = true


## If sprite hurts player
func _on_attack_zone_body_entered(body):
	if body.is_in_group("Playable"):
		## Reduce player's health on collision
		body.health -= 1
		#body.render_hit()
		#Game.hp -= 1
