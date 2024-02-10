extends Label


func _ready():
	set_text(str(get_parent().health))


func _process(_delta):
	set_text(str(get_parent().health))
