extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $target

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		# DAA: this makes sure than we will have a clean "fade_in"
		if anim_player.current_animation.empty():
			sprite.modulate.a = 0
		anim_player.play("fade_in")


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		# DAA: this is to avoid showing the cross when the mouse is over an agent. Not that elegant, I must say...
		if get_overlapping_bodies():
			anim_player.play("fade_out")
		else:
			anim_player.play("fade_in")
		global_position = get_global_mouse_position()


func _on_body_entered(body : PhysicsBody2D) -> void:
	anim_player.play("fade_out")	
