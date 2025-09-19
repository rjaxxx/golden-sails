extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.has_lost = false
	Globals.play_button_pressed = false
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.play_button_pressed == true:
		Globals.has_lost = false
		hide()
