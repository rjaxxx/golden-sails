extends Node3D

@export var speed: float = 15.0
@export var enemy_scene: PackedScene
@export var spawn_interval: float = 5.0  # seconds

var player: CharacterBody3D

func _ready():
	player = get_node("/root/Map/Player")

	# Timer for spawning clones
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_spawn_clone"))

func _physics_process(delta):
	if Globals.play_button_pressed and player:
		var direction = (player.global_position - global_position)
		velocity = direction.normalized() * speed
		move_and_slide()
		look_at(player.global_position, Vector3.UP)
		rotate_y(deg_to_rad(180))

func _spawn_clone():
	if enemy_scene == null or get_parent() == null:
		return

	var new_enemy = enemy_scene.instantiate()
	
	# Random spawn coordinates
	var enemy_x = randi_range(-1024, 1024)
	var enemy_y = 5
	var enemy_z = randi_range(-1024, 1024)
	
	new_enemy.global_position = Vector3(enemy_x, enemy_y, enemy_z)
	get_parent().add_child(new_enemy)
