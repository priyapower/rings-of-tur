extends CharacterBody2D


## Initialization ##
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D


## Constants ##
const SPEED = 200.0
const JUMP_HEIGHT = -350.0


## Variables ##
# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animation.play("Idle")


## Engine functions ##
func _physics_process(delta):
	# Handle flipping sprite
	if Input.is_action_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	elif Input.is_action_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_HEIGHT

	# Get the input direction and handle the movement/deceleration
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		animation.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


## Custom functions ##
