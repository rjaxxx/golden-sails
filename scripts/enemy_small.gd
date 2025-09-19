
extends CharacterBody3D

@export var speed: float = 15.0
@export var enemy_scene: PackedScene
@export var spawn_interval: float = 7.5  # seconds

var player: CharacterBody3D

func _ready():
	global_position = Vector3(0, 5, -200)
	player = get_node("/root/Map/Player")
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_spawn_clone"))

func _physics_process(delta):
	if Globals.has_lost == true:
			global_position = Vector3(0, 5, -200)
	
	if not is_inside_tree() or player == null or not Globals.play_button_pressed:
		return

	var direction = player.global_position - global_position
	if direction.length() > 0.1:
		velocity = direction.normalized() * speed
		move_and_slide()
		look_at(player.global_position, Vector3.UP)
		rotate_y(deg_to_rad(180))

func _spawn_clone():
	if enemy_scene == null or get_parent() == null:
		return

	call_deferred("_do_spawn")

func _do_spawn():
	var enemy_x = randi_range(-1024, 1024)
	var enemy_y = 5
	var enemy_z = randi_range(-1024, 1024)

	var new_enemy = enemy_scene.instantiate()

	get_parent().add_child(new_enemy)
	new_enemy.global_position = Vector3(enemy_x, enemy_y, enemy_z)
