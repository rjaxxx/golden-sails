extends Node

var play_button_pressed
var survey_entered
var shooting
var has_lost
var wood_count: int = 0
var rock_count: int = 0
var coin_count: int = 0
var coin_ui

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.play_button_pressed = false
	Globals.survey_entered = false
	Globals.shooting = false
	Globals.has_lost = false
	Globals.coin_ui = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
