extends KinematicBody2D


onready var sprite: Sprite = $TriangleRed

const DISTANCE_THRESHOLD := 3.0

export var max_speed := 500.0
var _velocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	var target_global_position: Vector2 = get_global_mouse_position()
	if global_position.distance_to(target_global_position) <  DISTANCE_THRESHOLD:
		return
	_velocity =  Steering.follow(
		_velocity,
		global_position,
		target_global_position,
		max_speed
	)
	_velocity = move_and_slide(_velocity)
	sprite.rotation = _velocity.angle()