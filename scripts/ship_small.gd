extends CharacterBody3D

const MAX_SPEED = 30.0
const ACCELERATION = 2.0
const DECELERATION = 2.0
const ROTATION_SPEED = 1
const TURN_INERTIA = 2.0
const SLIDE_FRICTION = 0.1

@export var cannonball_scene: PackedScene

var current_turn_velocity = 0.0
var current_speed = 0.0

var player_x = 32
var player_y = 5
var player_z = 0

var shoot_cooldown = 0.5
var time_since_last_shot = 0.0

func _ready():
	global_position = Vector3(player_x, player_y, player_z)

func _physics_process(delta):
	
	if time_since_last_shot < shoot_cooldown:
		time_since_last_shot += delta
	
	if Globals.play_button_pressed == true:
		var move_input = Input.get_action_strength("ui_up")
		var turn_input = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")

		if abs(current_speed) > 6:
			current_turn_velocity = lerp(current_turn_velocity, turn_input * ROTATION_SPEED, TURN_INERTIA * delta)
		else:
			current_turn_velocity = lerp(current_turn_velocity, 0.0, TURN_INERTIA * delta)

		rotation.y += current_turn_velocity * delta

		var forward = transform.basis.z.normalized()

		if move_input != 0:
			current_speed = lerp(current_speed, MAX_SPEED * move_input, ACCELERATION * delta)
		else:
			current_speed = lerp(current_speed, 0.0, DECELERATION * delta)

		velocity.x = lerp(velocity.x, forward.x * current_speed, SLIDE_FRICTION)
		velocity.z = lerp(velocity.z, forward.z * current_speed, SLIDE_FRICTION)

		move_and_slide()
	
	if Globals.has_lost == true:
		get_tree().change_scene_to_file("res://levels/menu.tscn")
		

func shoot_cannonball():
	var cannonball = cannonball_scene.instantiate() as Area3D
	get_tree().current_scene.add_child(cannonball)
	var spawn_transform = global_transform
	spawn_transform.origin.y += 3
	cannonball.global_transform = spawn_transform
	cannonball.direction = global_transform.basis.z.normalized()


func _input(event):
	if event.is_action_pressed("ui_accept") and time_since_last_shot >= shoot_cooldown:
		shoot_cannonball()
		time_since_last_shot = 0.0
