extends Area3D

@onready var inventory = get_node("../inventory ui2")
@onready var coin_icons := inventory.get_children().filter(func(c): return c is Sprite2D)

var reveal_timer: Timer
var current_index := 0

func _ready():
	inventory.visible = false
	_update_icons()

	reveal_timer = Timer.new()
	reveal_timer.wait_time = 1.0
	reveal_timer.one_shot = false
	reveal_timer.autostart = false
	reveal_timer.timeout.connect(_on_reveal_timeout)
	add_child(reveal_timer)


func _on_body_entered(body):
	if body.is_in_group("player"):
		inventory.visible = true
		current_index = Globals.coin_count
		reveal_timer.start()

func _on_body_exited(body):
	if body.is_in_group("player"):
		inventory.visible = false
		reveal_timer.stop()

func _on_reveal_timeout():
	if current_index < Globals.wood_count:
		coin_icons[current_index].visible = true
		Globals.wood_count -= 1
		current_index += 1
		Globals.coin_count += 1
	else:
		reveal_timer.stop()

func _update_icons():
	# Hide all icons first
	for icon in coin_icons:
		icon.visible = false
