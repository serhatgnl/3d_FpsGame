extends Node3D

@export var weapon : WeaponController


@export var emitter : GPUParticles3D
@export var emitter_2 : GPUParticles3D

@export var sound : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon.weapon_fired.connect(add_muzzle_flash)

func add_muzzle_flash() -> void:
	emitter.emitting = true
	emitter_2.emitting = true
	sound.play()
	
	
