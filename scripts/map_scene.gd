# Attach this to your map Control node, for example.

extends Control

@export var player_3d: Node3D
@export var player_marker: Node2D

# Define the bounds of your 3D world:
@export var world_min: Vector3
@export var world_max: Vector3

# Define the 2D map area in pixels:
var map_size: Vector2

func _ready():
	pass

func _process(delta):
	update_player_marker()

func update_player_marker():
	var player_pos = player_3d.global_position

	# Normalise the 3D position into 0..1 range
	var normalized_x = (player_pos.x - world_min.x) / (world_max.x - world_min.x)
	var normalized_z = (player_pos.z - world_min.z) / (world_max.z - world_min.z)

	# Flip Z if needed (depends on your map orientation!)
	normalized_z = 1.0 - normalized_z

	# Scale to map size
	var map_pos = Vector2(normalized_x * map_size.x, normalized_z * map_size.y)

	# Move the marker
	player_marker.position = map_pos
