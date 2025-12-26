class_name  CrouchingPlayerState

extends PlayerMovementState

@export var speed_crouch: float = 3.0
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
@export_range(1, 6, 0.1) var crouch_speed : float = 4.0
@export var weapon_bob_spd : float = 3.0
@export var weapon_bob_h : float = 1.0
@export var weapon_bob_v : float = 0.5

@onready var crouch_shapecast : ShapeCast3D = %ShapeCast3D

func enter() -> void:
	anim.play("Crouch", -1.0, crouch_speed)
	
func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(speed_crouch, acceleration, deceleration, delta)
	PLAYER.update_velocity()
	
	weapon.sway_weapon(delta, false)
	weapon._weapon_bob(delta, weapon_bob_spd, weapon_bob_h, weapon_bob_v)
	
	
	if Input.is_action_just_released("crouch"):
		uncrouch()
		
		
func uncrouch():
	if crouch_shapecast.is_colliding() == false and Input.is_action_pressed("crouch") == false:
		anim.play("Crouch", -1.0, -crouch_speed * 1.5, true)
		if anim.is_playing():
			await anim.animation_finished
		transition.emit("IdlePlayerState")
	elif crouch_shapecast.is_colliding() == true:
		await  get_tree().create_timer(0.1).timeout
		uncrouch()
		
