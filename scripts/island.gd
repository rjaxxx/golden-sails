extends Area3D

@onready var inventory = get_node("../inventory ui2")
@onready var coin_icons := inventory.get_children().filter(func(c): return c is Sprite2D)

var reveal_timer: Timer
var current_index := 0

func _ready():
	inventory.visible = false
	_update_icons()

	reveal_timer = Timer.new()
	reveal_timer.wait_time = 5.0
	reveal_timer.one_shot = false
	reveal_timer.autostart = false
	reveal_timer.timeout.connect(_on_reveal_timeout)
	add_child(reveal_timer)

func _on_body_entered(body):
	if body.is_in_group("player"):
		inventory.visible = true
		Globals.coin_ui = true
		current_index = Globals.coin_count
		reveal_timer.start()

func _on_body_exited(body):
	if body.is_in_group("player"):
		inventory.visible = false
		Globals.coin_ui = false
		reveal_timer.stop()

func _on_reveal_timeout():
	if current_index < coin_icons.size():
		coin_icons[current_index].visible = true
	Globals.coin_count += 1
	current_index += 1

func _update_icons():
	for icon in coin_icons:
		icon.visible = false
