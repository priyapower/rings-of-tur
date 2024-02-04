extends CharacterBody2D


const SPEED = 200
const JUMP_VELOCITY = -400


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Grab the player's animations
@onready var anim = get_node("AnimationPlayer")


# Sprite player with Idle animation
func _ready():
	anim.play("Idle")


func _physics_process(delta):
	# Add gravity to pull player down after a jump
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump if they press up on keypad and are not on floor
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Handle direction of image/animation
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true;
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false;
	
	# Handle running animation and movement speed
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	# Handle idle animation reset
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	
	# Handle falling animation
	if velocity.y > 0:
		anim.play("Fall")
		
	# Play death
	if Game.hp <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
	
	# Physics function for movement
	move_and_slide()

func render_hit():
	print("hit render")
	#anim.play("Hit")
	Game.hp -= 1


# Handle health and death
#func _on_animation_player_animation_finished(anim_name):
	#print("yooooooo")
	#print(anim_name)
	#print(str(anim_name))
	#if anim_name == "Hit" && health < FULL_HEALTH && health > 0:
		#print("inside hit condition")
		##anim.stop()
	#elif anim_name == "Hit" && health <= 0:
		#print("inside death conditon")
		##anim.stop()
		### Remove player
		##queue_free()
		### Go back to main menu
		##get_tree().change_scene_to_file("res://main.tscn")
#
#
#func _on_animated_sprite_2d_animation_finished():
	## Remove sprite if death animation plays
	#if get_node("AnimatedSprite2D").animation == "Hit":
		##get_node("AnimatedSprite2D").stop()
		### Learning note: queue_free() is the same as self.queue_free()
		##queue_free()
		#print("inside secondary hit condition")
