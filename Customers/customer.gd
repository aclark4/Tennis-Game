extends CharacterBody2D

enum CustomerState {
	WALKING,
	WAITING,
	BEING_SERVED,
	LEAVING
}
var state: CustomerState = CustomerState.WALKING

@onready var sprite: Sprite2D = $Sprite2D
@onready var indicator: Sprite2D = $Indicator
@onready var walkTimer: Timer = $WalkTimer
const MOVEMENT_SPEED: float = 50
const JUMP_VELOCITY = -100.0
const GRAVITY: float = 900.0

var shop_x: float = 120.0
var wanted_item: Item = null

func _ready() -> void:
	indicator.visible = false
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	match state: # Logic of what the customer does depending on the state it is in
		CustomerState.WALKING:
			var dir = sign(shop_x - position.x)
			if abs(position.x - shop_x) < 2.0:
				position.x = shop_x
				velocity.x = 0
				_arrive()
			else:
				if walkTimer.is_stopped():
					if sprite.frame == 3:
						sprite.frame = 2
					else:
						sprite.frame = 3
					walkTimer.start()
				velocity.x = dir * MOVEMENT_SPEED
				sprite.flip_h = dir < 0
				
		CustomerState.WAITING:
			sprite.frame = 1 # Face the shop
			velocity.x = 0
			indicator.position.y = -27 + sin(Time.get_ticks_msec() * 0.005) * 2.0
			
		CustomerState.BEING_SERVED:
			velocity.x = 0
			indicator.visible = false
			
		CustomerState.LEAVING:
			var dir = sign(position.x - 160)
			velocity.x = dir * MOVEMENT_SPEED
			sprite.flip_h = dir < 0
			if position.x > 340 or position.x < -20:
				GameData.customer_queue.erase(self)
				queue_free()
	move_and_slide()

func _arrive() -> void:
	state = CustomerState.WAITING
	indicator.visible = true
	GameData.customer_queue.append(self)
