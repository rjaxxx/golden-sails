extends Area3D

@export var speed: float = 50.0
var direction: Vector3 = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	var mesh = $MeshInstance3D
	if mesh:
		mesh.scale = Vector3(3, 3, 3)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_translate(direction * speed * delta)
