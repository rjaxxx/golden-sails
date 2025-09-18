extends Area3D

@onready var inventory = get_node("../inventory ui3")
@onready var rock_icons := inventory.get_children().filter(func(c): return c is Sprite2D)

var reveal_timer: Timer
var current_index := 0

func _process(_delta):
	if Globals.has_lost == true:
		inventory.visible = false

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
		_update_icons()
		current_index = Globals.rock_count
		if Globals.rock_count < rock_icons.size():
			reveal_timer.start()

func _on_body_exited(body):
	if body.is_in_group("player"):
		inventory.visible = false
		reveal_timer.stop()

func _on_reveal_timeout():
	if current_index < rock_icons.size():
		rock_icons[current_index].visible = true
		Globals.rock_count += 1
		current_index += 1
	else:
		reveal_timer.stop()

func _update_icons():
	for i in range(rock_icons.size()):
		rock_icons[i].visible = i < Globals.rock_count
