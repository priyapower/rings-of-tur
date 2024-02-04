extends Node

const SAVE_PATH : String = "res://savegame.bin"


func reset_game():
	Game.hp = Game.RESET_HP
	Game.gold = Game.RESET_GOLD
	save_game()


func save_game():
	var file : FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data : Dictionary = {
		"hp": Game.hp,
		"gold": Game.gold,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)


func load_game():
	var file : FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	#Learning note: can be explicit with
	#if FileAccess.file_exists(SAVE_PATH) == true:
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.hp = current_line["hp"]
				Game.gold = current_line["gold"]
	#Learning note: Godot 3 you had to close the file; no longer required
	#file.close()
