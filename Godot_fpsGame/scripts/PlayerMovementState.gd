class_name PlayerMovementState

extends State

var PLAYER: Player
var anim: AnimationPlayer
var weapon : WeaponController


func _ready() -> void:
	await owner.ready
	PLAYER = owner as Player
	anim = PLAYER.ANIMATION_PLAYER
	weapon = PLAYER.weapon_controller



func _process(delta: float) -> void:
	pass
