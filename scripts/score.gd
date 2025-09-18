extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	print("RichTextLabel script ready!")
	set_process(true)
	Globals.coin_ui = false
	visible = true
	text = "Score test"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var coins = 0
	if Globals.has("coin_count"):
		coins = Globals.coin_count
	print(coins)
	text = "Score " + str(coins)

func _input(event):
	if event.is_action_pressed("ui_accept"):  # e.g., press Enter
		Globals.coin_count += 1
		print("Coin count increased: ", Globals.coin_count)
