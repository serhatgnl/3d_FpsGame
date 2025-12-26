extends CenterContainer
@export var SIGHT_LINES : Array[Line2D]
@export var PLAYER_CONTROLLER : CharacterBody3D
@export var SIGHT_SPEED : float = 0.25
@export var SIGHT_DISTANCE : float = 2.0

@export var Radius : float = 2.0
@export var _Color : Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	adjust_sight_lines()
	
func _draw() -> void:
	draw_circle(Vector2(0,0), Radius, _Color)
	
func adjust_sight_lines():
	var vel = PLAYER_CONTROLLER.get_real_velocity()
	var origin = Vector3(0,0,0)
	var pos = Vector2(0,0)
	var speed = origin.distance_squared_to(vel)
	
	SIGHT_LINES[0].position = lerp(SIGHT_LINES[0].position, pos + Vector2(0, -speed * SIGHT_DISTANCE), SIGHT_SPEED)
	SIGHT_LINES[1].position = lerp(SIGHT_LINES[1].position, pos + Vector2(-speed * SIGHT_DISTANCE, 0), SIGHT_SPEED)
	SIGHT_LINES[2].position = lerp(SIGHT_LINES[2].position, pos + Vector2(0, speed * SIGHT_DISTANCE), SIGHT_SPEED)
	SIGHT_LINES[3].position = lerp(SIGHT_LINES[3].position, pos + Vector2(speed * SIGHT_DISTANCE, 0), SIGHT_SPEED)
	
