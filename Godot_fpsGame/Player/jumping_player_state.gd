class_name JumpingPlayerState

extends PlayerMovementState

@export var SPEED : float = 6.0
@export var acceleration : float = 0.1
@export var deceleration : float = 0.25
@export_range(0.5, 1.0, 0.01) var input_multiplier : float = 0.85
@export var jump_velocity : float = 4.5
@export var double_jump_velocity : float = 4.5

var double_jump : bool = false

func enter() -> void:
	PLAYER.velocity.y += jump_velocity
	anim.pause()
	
func exit() -> void:
	double_jump = false

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED * input_multiplier, acceleration, deceleration, delta)
	PLAYER.update_velocity()
	
	if Input.is_action_just_pressed("jump") and double_jump == false:
		double_jump == true
		PLAYER.velocity.y = double_jump_velocity
		
	if Input.is_action_just_released("jump"):
		if PLAYER.velocity.y > 0:
			PLAYER.velocity.y = PLAYER.velocity.y / 2.0
	
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	
