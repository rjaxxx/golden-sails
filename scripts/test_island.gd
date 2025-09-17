extends Area3D

@onready var inventory = get_node("../inventory ui")
@onready var wood_icons := inventory.get_children().filter(func(c): return c is Sprite2D)

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

func _process(delta):
	print(Globals.wood_count)
	print(Globals.coin_count)

func _on_body_entered(body):
	if body.is_in_group("player"):
		inventory.visible = true
		current_index = Globals.wood_count
		reveal_timer.start()

func _on_body_exited(body):
	if body.is_in_group("player"):
		inventory.visible = false
		reveal_timer.stop()

func _on_reveal_timeout():
	if current_index < wood_icons.size():
		wood_icons[current_index].visible = true
		Globals.wood_count += 1
		current_index += 1
	else:
		reveal_timer.stop()

func _update_icons():
	for i in range(wood_icons.size()):
		wood_icons[i].visible = i < Globals.wood_count
