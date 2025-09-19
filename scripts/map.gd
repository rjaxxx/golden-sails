extends Node3D

@onready var player = $Player
@onready var map_background = $"map background"
@onready var player_icon = $"player icon"
@onready var island2_icon = $"island 2 icon"
@onready var island3_icon = $"island 3 icon"
@onready var island4_icon = $"island 4 icon"

@export var world_min: Vector3 = Vector3(-512, 0, -512)
@export var world_max: Vector3 = Vector3(512, 0, 512)

var map_visible := false

func _ready():
	Globals.has_lost = false
	Globals.coin_count = 0
	Globals.wood_count = 0
	Globals.rock_count = 0
	map_background.visible = false
	player_icon.visible = false
	island2_icon.visible = false
	island3_icon.visible = false
	island4_icon.visible = false

	update_island2_icon()
	update_island3_icon()
	update_island4_icon()

func _process(delta):
	if Input.is_action_just_pressed("map"):
		toggle_map()

	if map_visible:
		update_map_icon()
		
	if Globals.has_lost == true:
		map_visible = false
		Globals.wood_count = 0
		Globals.rock_count = 0

func toggle_map():
	map_visible = !map_visible
	map_background.visible = map_visible
	player_icon.visible = map_visible
	island2_icon.visible = map_visible
	island3_icon.visible = map_visible
	island4_icon.visible = map_visible


func update_map_icon():
	var player_pos = player.global_position

	var nx = (player_pos.x - world_min.x) / (world_max.x - world_min.x)
	var nz = (player_pos.z - world_min.z) / (world_max.z - world_min.z)

	nx = clamp(nx, 0.0, 1.0)
	nz = clamp(nz, 0.0, 1.0) 

	var map_size = map_background.texture.get_size()
	var bg_pos = map_background.position

	var local_pos = Vector2(nx * map_size.x, nz * map_size.y)
	player_icon.position = bg_pos + local_pos - (map_size / 2)

func update_island2_icon():
	# Tree Island
	var island2_world = Vector3(250, 0, 150)

	var ix = (island2_world.x - world_min.x) / (world_max.x - world_min.x)
	var iz = (island2_world.z - world_min.z) / (world_max.z - world_min.z)

	ix = clamp(ix, 0.0, 1.0)
	iz = clamp(iz, 0.0, 1.0)

	var map_size = map_background.texture.get_size()
	var bg_pos = map_background.position

	var local_pos = Vector2(ix * map_size.x, iz * map_size.y)
	island2_icon.position = bg_pos + local_pos - (map_size / 2)
	
func update_island3_icon():
# Trading Island
	var island3_world = Vector3(0, 0, -410)

	var ix = (island3_world.x - world_min.x) / (world_max.x - world_min.x)
	var iz = (island3_world.z - world_min.z) / (world_max.z - world_min.z)

	ix = clamp(ix, 0.0, 1.0)
	iz = clamp(iz, 0.0, 1.0)

	var map_size = map_background.texture.get_size()
	var bg_pos = map_background.position

	var local_pos = Vector2(ix * map_size.x, iz * map_size.y)
	island3_icon.position = bg_pos + local_pos - (map_size / 2)

func update_island4_icon():
# Rock Island
	var island4_world = Vector3(-300, 0, 150)

	var ix = (island4_world.x - world_min.x) / (world_max.x - world_min.x)
	var iz = (island4_world.z - world_min.z) / (world_max.z - world_min.z)

	ix = clamp(ix, 0.0, 1.0)
	iz = clamp(iz, 0.0, 1.0)

	var map_size = map_background.texture.get_size()
	var bg_pos = map_background.position

	var local_pos = Vector2(ix * map_size.x, iz * map_size.y)
	island4_icon.position = bg_pos + local_pos - (map_size / 2)
