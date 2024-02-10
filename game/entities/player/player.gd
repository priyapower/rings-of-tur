class_name Player
extends CharacterBody2D


## CUSTOMIZABLE VARS
@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var jump_state_machine = $JumpStateMachine
@onready var run_state_machine = $RunStateMachine
@onready var move_component = $PlayerMove
#@onready var ray_cast = $RayCastCrouch


## BEHAVIORS
func _ready() -> void:
	## Initialize each state machine
	## Each machine will pass a reference
	## of the Player (self) to each machine's state
	## so they can move and react accordingly
	jump_state_machine.init(self, animations, move_component)
	run_state_machine.init(self, animations, move_component)


## PASS PROCESSES THROUGH TO STATE MACHINE
func _unhandled_input(event: InputEvent) -> void:
	jump_state_machine.process_input(event)
	run_state_machine.process_input(event)


func _process(delta: float) -> void:
	jump_state_machine.process_frame(delta)
	run_state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	jump_state_machine.process_physics(delta)
	run_state_machine.process_physics(delta)
