extends Area3D

func _ready():
	pass

func _on_area_entered(area):
	if area.is_in_group("cannonball"):
		get_parent().queue_free()

func _physics_process(delta):
	pass
