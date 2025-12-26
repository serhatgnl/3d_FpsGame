class_name Player extends CharacterBody3D


@export var cam : Node3D
@export var cam_speed : float = 0.005
@export var cam_rotation_amount : float = 0.05
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
#@export_range(4,8,0.2) var crouch_speed : float = 4.0
@export var ANIMATION_PLAYER : AnimationPlayer
@export var Crouch_ShapeCast : Node3D
@export var speed_default: float = 6.0
@export var speed_crouch : float = 3.0
@export var weapon_controller : WeaponController
@export var camera_controller : Camera3D
@export var game_music : AudioStreamPlayer


var mouse_input : Vector2
var _is_crouching : bool = false
var _speed : float




func _ready() -> void:
	Global.player = self
	game_music.play()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	_speed = speed_default
	
	Crouch_ShapeCast.add_exception($".")

func _input(event: InputEvent) -> void:
	if !cam : return
	if event is InputEventMouseMotion:
		cam.rotation.x -= event.relative.y * cam_speed
		cam.rotation.x = clamp(cam.rotation.x , -PI/2, PI/2)
		self.rotation.y -= event.relative.x * cam_speed
		mouse_input = event.relative
		
		
	if event.is_action_pressed("exit"):
		get_tree().quit()
	
		
func _physics_process(delta: float) -> void:
	
	Global.debug.add_property("MovementSpeed", _speed, 1)
	Global.debug.add_property("Camtilt", cam_rotation_amount, 2)
	Global.debug.add_property("Velocity", "%.2f" % velocity.length(), 3)
	
	
func update_gravity(delta) -> void:
	velocity += get_gravity() * delta
	
func update_input(speed: float, acceleration: float, deceleration: float, delta: float) -> void:
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * _speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * _speed, acceleration)
	
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
		
	cam_tilt(input_dir.x, delta)

func update_velocity() -> void:
	move_and_slide()
	

func cam_tilt(input_x, delta):
	if cam:
		cam.rotation.z = lerp(cam.rotation.z, -input_x * cam_rotation_amount, 10 * delta)
		
		
