extends KinematicBody2D


onready var sprite: Sprite = $TriangleRed
onready var target := get_node(target_path)
onready var target_sprite: Sprite = $TargetSprite	#DAA: not included in tutorial, but seen on videos. Nice to see what's happening


const ARRIVE_THRESHOLD := 3.0

export var target_path := NodePath()
export var follow_offset := 200.0
export var slow_radius := 200.0
export var mass := 20.0

export var max_speed := 500.0
var _velocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	if target == self:
		set_physics_process(false)
	var target_global_position: Vector2 = target.global_position
	
	var to_target := global_position.distance_to(target_global_position)
	if to_target <  ARRIVE_THRESHOLD:
		return
		
	var follow_global_position: Vector2 = (
		target.global_position - (target_global_position - global_position).normalized() * follow_offset
		if to_target > follow_offset
		else global_position
	)
	
	_velocity =  Steering.arrive_to(
		_velocity,
		global_position,
		follow_global_position,
		max_speed,
		slow_radius,
		mass
	)
	_velocity = move_and_slide(_velocity)
	sprite.rotation = _velocity.angle()
	target_sprite.global_position = follow_global_position
