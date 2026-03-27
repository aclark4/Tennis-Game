extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var walkTimer: Timer = $WalkTimer

@export var movement_speed: float = 65
@export var jump_velo = -100.0

const GRAVITY: float = 900.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velo
	
	var mov_x: float = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if mov_x < 0:
		sprite.flip_h = true
	elif mov_x > 0:
		sprite.flip_h = false
	
	if mov_x != 0:
		if walkTimer.is_stopped():
			if sprite.frame == 2:
				sprite.frame = 1
			else:
				sprite.frame = 2
			walkTimer.start()
	else:
		sprite.flip_h = false
		sprite.frame = 0
		
	velocity.x = mov_x*movement_speed
	move_and_slide()


func _on_night_time_make_player_platformer() -> void:
	movement_speed = 90
	jump_velo = -200
