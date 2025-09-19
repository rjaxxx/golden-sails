extends RichTextLabel
var coins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	Globals.coin_ui = false
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Globals.scoreui == true:
		coins = Globals.coin_count
		text = "Score " + str(coins)
		Globals.coin_count = 0
		Globals.scoreui = false
