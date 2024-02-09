class_name Player
extends CharacterBody2D


## CUSTOMIZABLE VARS
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var jumping_state_machine = $JumpStateMachine
@onready var ray_cast = $RayCastCrouch


## BEHAVIORS
func _ready() -> void:
	## Initialize each state machine
	## Each machine will pass a reference
	## of the Player (self) to each machine's state
	## so they can move and react accordingly
	jumping_state_machine.init(self)


## PASS PROCESSES THROUGH TO STATE MACHINE
func _unhandled_input(event: InputEvent) -> void:
	jumping_state_machine.process_input(event)


func _process(delta: float) -> void:
	jumping_state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	jumping_state_machine.process_physics(delta)
