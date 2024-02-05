extends Node2D


func _ready():
	if Game.hp <= 0:
		# Reset game stats
		Utils.reset_game()
	else:
		# Load game states from file
		Utils.load_game()


func _on_quit_pressed():
	get_tree().quit();


func _on_play_pressed():
	get_tree().change_scene_to_file("res://intro.tscn")
