extends CharacterBody2D


const SPEED = 75


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#@onready var player = get_node("../../Player/Player")
var chase = false


# Sprite starts with Idle animation
func _ready():
	get_node("AnimatedSprite2D").play("Idle")


func _physics_process(delta):
	# Gravity for sprite
	velocity.y += gravity * delta
	
	# Chase behavior
	if chase == true:
		# Handle death animation condition
		#if get_node("AnimatedSprite2D").animation != "Death":
		# Play attack animation
		get_node("AnimatedSprite2D").play("Attack")
		
		# Get the Player object 
		var player = get_node("../../Player/Player")
		
		# Learning note: position is the same as self.position
		var direction = (player.position - position).normalized()
		
		# Handle direction of sprite movement/animation
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			
		else:
			get_node("AnimatedSprite2D").flip_h = false
		
		# Chase
		velocity.x = direction.x * SPEED
	else:
		# Handle death animation condition
		if get_node("AnimatedSprite2D").animation != "Death":
			# Reset animation to idle
			get_node("AnimatedSprite2D").play("Idle")
		
		# Stop chasing
		velocity.x = 0
	
	# Physics movement
	move_and_slide()


# If player is detected
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


# If player outside detection range
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


# If player kills sprite (jump on it)
func _on_death_body_entered(body):
	if body.name == "Player":
		# Give player money
		Game.gold += 5
		Utils.save_game()
		
		# Stop chasing
		chase = false
		
		# Play death animation
		get_node("AnimatedSprite2D").play("Death")


# If sprite hurts player
func _on_hurt_player_body_entered(body):
	if body.name == "Player":
		# Reduce player's health on collision
		#body.health -= 1
		#body.render_hit()
		Game.hp -= 1


func _on_animated_sprite_2d_animation_finished():
	# Remove sprite if death animation plays
	if get_node("AnimatedSprite2D").animation == "Death":
		get_node("AnimatedSprite2D").stop()
		# Learning note: queue_free() is the same as self.queue_free()
		queue_free()
