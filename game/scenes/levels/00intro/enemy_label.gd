extends Label


func _ready():
	set_text(get_parent().name)


func _process(_delta):
	set_text(get_parent().name)
