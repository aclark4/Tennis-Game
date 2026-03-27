extends CharacterBody2D
class_name Customer

enum CustomerState {
	WALKING,
	WAITING,
	BEING_SERVED,
	LEAVING
}
var state: CustomerState = CustomerState.WALKING


var profile: CustomerProfile = null
var spawn_direction: int = 0

#Signals (very important for dependency reduction)
signal arrived
signal left

@onready var sprite: Sprite2D = $Sprite2D
@onready var indicator: Sprite2D = $Indicator
@onready var impatient: Sprite2D = $Impatient
@onready var walkTimer: Timer = $WalkTimer
@onready var waitTimer: Timer = $WaitTimer

@export var from_right: bool

const MOVEMENT_SPEED: float = 50
const JUMP_VELOCITY = -100.0
const GRAVITY: float = 900.0

var shop_x: float = 120.0
var wanted_item: Item = null

func _ready() -> void:
	if from_right: spawn_direction = 1 
	else: spawn_direction = -1
	indicator.visible = false
	impatient.visible = false
	
func setup(p: CustomerProfile) -> void:
	profile = p
	assert(profile.sprite != null, "Customer '" + profile.customer_name + "' is missing a sprite!")
	sprite.texture = profile.sprite
	if profile.sprite:
		sprite.texture = profile.sprite
		sprite.hframes = 2
		sprite.vframes = 2
	waitTimer.wait_time = profile.impatient_time
	wanted_item = _pick_wanted_item()
	
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
			if waitTimer.time_left > 5:
				indicator.position.y = -27 + sin(Time.get_ticks_msec() * 0.005) * 2.0
			else:
				impatient.visible = true
				indicator.visible = false
				impatient.position.y = -27 + sin(Time.get_ticks_msec() * 0.005) * 2.0
		
		CustomerState.BEING_SERVED:
			sprite.frame = 0
			velocity.x = 0
			indicator.visible = false
			impatient.visible = false
			
			
		CustomerState.LEAVING:
			if position.x > 340 or position.x < -20:
				left.emit()
				queue_free()
			else:
				if walkTimer.is_stopped():
					if sprite.frame == 3:
						sprite.frame = 2
					else:
						sprite.frame = 3
					walkTimer.start()
				velocity.x = spawn_direction * MOVEMENT_SPEED
				sprite.flip_h = spawn_direction < 0
	move_and_slide()

func _arrive() -> void:
	state = CustomerState.WAITING
	waitTimer.start()
	indicator.visible = true
	arrived.emit() 

func reposition(new_x: float) -> void:
	shop_x = new_x
	state = CustomerState.WALKING
	indicator.visible = false
	
func _pick_wanted_item() -> Item: # This does not work properly quite yet
	var pool: Array[Item] = ItemDatabase.get_items_by_type(profile.personality)
	var available: Array[Item] = pool.filter(func(item: Item) -> bool:
		return not profile.has_item(item))
	if available.is_empty():
		return null
	return available.pick_random()

func receive_item(item: Item) -> void:
	profile.add_item(item) 
	GameData.save_profiles()
	GameData.customer_queue.erase(self)
	indicator.visible = false
	state = CustomerState.LEAVING

func _on_wait_timer_timeout() -> void:
	print("Took too long!")
	impatient.visible = false
	state = CustomerState.LEAVING
