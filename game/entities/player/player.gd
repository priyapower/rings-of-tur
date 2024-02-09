class_name Player
extends CharacterBody2D


## Player exported vars ##
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var jumping_state_machine = $JumpStateMachine
@onready var ray_cast = $RayCastCrouch


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	jumping_state_machine.init(self)
#
#
#func _unhandled_input(event: InputEvent) -> void:
	#state_machine.process_input(event)
#
#
#func _physics_process(delta: float) -> void:
	#state_machine.process_physics(delta)
#
#
#func _process(delta: float) -> void:
	#state_machine.process_frame(delta)
