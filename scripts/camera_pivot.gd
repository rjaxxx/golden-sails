extends Node3D


var target: CharacterBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	target = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		global_position = target.global_position
		global_rotation_degrees = Vector3(-30, 45, 0)
