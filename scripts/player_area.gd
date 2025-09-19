extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		get_tree().change_scene_to_file("res://levels/menu.tscn")
		Globals.has_lost = true
		Globals.scoreui = true
