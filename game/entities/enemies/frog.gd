class_name Frog
extends CharacterBody2D


@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var move_component = $FrogMove


var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase: bool = false
var attack_speed: float = 75.0


# Sprite starts with Idle animation
func _ready():
	animations.play("Idle")


func _physics_process(delta):
	# Gravity for sprite
	velocity.y += gravity * delta
	
	# Chase behavior
	if chase == true:
		# Play attack animation
		animations.play("Attack")

		# Learning note: position is the same as self.position
		var horizontal_direction = move_component.get_horizontal_movement()

		# Handle horizontal_direction of sprite movement/animation
		if horizontal_direction > 0:
			animations.flip_h = true
		else:
			animations.flip_h = false

		# Chase
		velocity.x = horizontal_direction * attack_speed
	else:
		# Handle death animation condition
		if animations.animation != "Death":
			# Reset animation to idle
			animations.play("Idle")

		# Stop chasing
		velocity.x = 0

	# Physics movement
	move_and_slide()


# If player is detected
func _on_player_detection_body_entered(body):
	if body.is_in_group("Playable"):
		move_component.playable_body = body
		chase = true


# If player outside detection range
func _on_player_detection_body_exited(body):
	if body.is_in_group("Playable"):
		chase = false


# If player kills sprite (jump on it)
func _on_death_body_entered(body):
	print("DEATH CONDITION")
	if body.is_in_group("Playable"):
		print("Player condition met for DEATH CONDITION")
		# Give player money
		#Game.gold += 5
		#Utils.save_game()
		
		# Stop chasing
		chase = false
		
		# Play death animation
		animations.play("Death")
		print("Just played animation DEATH CONDITION")


# If sprite hurts player
func _on_hurt_player_body_entered(body):
	if body.is_in_group("Playable"):
		# Reduce player's health on collision
		#body.health -= 1
		#body.render_hit()
		Game.hp -= 1


func _on_animated_sprite_2d_animation_finished():
	# Remove sprite if death animation plays
	if animations.animation == "Death":
		animations.stop()
		# Learning note: queue_free() is the same as self.queue_free()
		queue_free()
