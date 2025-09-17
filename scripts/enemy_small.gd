extends CharacterBody3D

@export var speed: float = 15.0
@export var enemy_scene: PackedScene

var player: CharacterBody3D

var enemy_x = 60
var enemy_y = 5
var enemy_z = -60

func _ready():
	player = get_node("/root/Map/Player")

func _physics_process(delta):
	if Globals.survey_entered == true:
		if player:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * speed
			move_and_slide()
			if direction.length() > 0.1:
				look_at(player.global_position, Vector3.UP)
				rotate_y(deg_to_rad(180))
				
	if Globals.has_lost == true:
		global_position = Vector3(enemy_x, enemy_y, enemy_z)
