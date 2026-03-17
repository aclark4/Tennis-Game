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
var customer_pool: Array[CustomerProfile] = []
var active_customer_ids: Array[String] = []


func _ready() -> void:
	_load_customer_pool()
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
	var available = customer_pool.filter(func(d): return not active_customer_ids.has(d.id))
	if available.is_empty():
		return
		
	var customer: Customer = customer_scene.instantiate()
	customer.from_right = randi() % 2 == 0
	customer.position = Vector2(340 if customer.from_right else -20, spawn_y)
	customer.shop_x = get_queue_x(active_customers)
	active_customers += 1
	
	var definition: CustomerProfile = available.pick_random()
	var profile: CustomerProfile = GameData.get_or_create_profile(definition.id, definition.customer_name, definition.personality)
	active_customer_ids.append(definition.id)
	
	customer.arrived.connect(func(): GameData.customer_queue.append(customer))
	customer.left.connect(func():
		GameData.customer_queue.erase(customer)
		_reshuffle_queue())
	customer.tree_exited.connect(func(): active_customers -= 1)
	get_parent().add_child(customer)
	profile.sprite = definition.sprite
	customer.setup(profile)
	print(customer.name)
	print("Spawning")
	
func _reshuffle_queue()-> void:
	GameData.customer_queue = GameData.customer_queue.filter(func(c): return is_instance_valid(c))
	for i in GameData.customer_queue.size():
		var cust = GameData.customer_queue[i]
		var new_x = get_queue_x(i)
		if cust.shop_x != new_x:
			cust.reposition(new_x)
	
func _pick_random_item() -> Item:
	var all_items = ItemDatabase.Balls + ItemDatabase.Racquets + ItemDatabase.Bags + ItemDatabase.Shoes
	return all_items[randi() % all_items.size()]

func get_queue_x(index: int) -> float:
	var distance = (index + 1) / 2
	var direction = 1 if index % 2 == 0 else -1
	return shop_front_x + direction * distance * queue_spacing
	
func _load_customer_pool() -> void:
	var dir = DirAccess.open("res://Customers/")
	dir.list_dir_begin()
	var folder = dir.get_next()
	while folder != "":
		if dir.current_is_dir() and not folder.begins_with("."):
			var profile_path: String = "res://Customers/" + folder + "/" + folder + ".tres"
			if ResourceLoader.exists(profile_path):
				var profile = load(profile_path)
				if profile is CustomerProfile:
					print(profile.customer_name)
					customer_pool.append(profile)
		folder = dir.get_next()
