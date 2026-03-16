extends Node

@export var customer_scene: PackedScene
@export var max_customers: int = 5
@export var min_spawn_time: float = 10.0
@export var max_spawn_time: float = 30
@export var shop_front_x: float = 68.0
@export var queue_spacing: float = 15.0
@export var spawn_y: float = 130.0

@onready var timer: Timer = $Timer

var active_customers: int = 0

func _ready() -> void:
	_schedule_next_spawn()

func _on_timer_timeout() -> void:
	if active_customers < max_customers:
		print("AHHHHH")
		_spawn_customer()
	_schedule_next_spawn()

func _schedule_next_spawn() -> void:
	print("Scheduling...")
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	print("Timer starting: Wait time is ", timer.wait_time)
	timer.start()
	
func _spawn_customer() ->void:
	var customer = customer_scene.instantiate()
	var from_right: bool = randi() % 2 == 0
	customer.position = Vector2(340 if from_right else -20, spawn_y)
	customer.shop_x = get_queue_x(active_customers)
	customer.wanted_item = _pick_random_item()
	active_customers += 1
	customer.tree_exited.connect(func(): 
		active_customers -= 1
		_reshuffle_queue())
	get_parent().add_child(customer)
	print("Spawning")
	
func _reshuffle_queue()-> void:
	for i in GameData.customer_queue.size():
		var cust = GameData.customer_queue[i]
		var new_x = get_queue_x(i)
		if cust.shop_x != new_x:
			cust.shop_x = new_x
			if cust.state == cust.CustomerState.WAITING:
				cust.state = cust.CustomerState.WALKING
				cust.indicator.visible = false
	
func _pick_random_item() -> Item:
	var all_items = ItemDatabase.Balls + ItemDatabase.Racquets + ItemDatabase.Bags + ItemDatabase.Shoes
	return all_items[randi() % all_items.size()]

func get_queue_x(index: int) -> float:
	var distance = (index + 1) / 2
	var direction = 1 if index % 2 == 0 else -1
	return shop_front_x + direction * distance * queue_spacing
