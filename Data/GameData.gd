extends Node

const SAVE_PATH = "user://customer_profiles.json"
var player_position: Vector2 = Vector2(147,137)

var shop_balls: Array[Item] = []
var shop_racquets: Array[Item] = []
var shop_bags: Array[Item] = []
var shop_shoes: Array[Item] = []

var player_coins: int = 0
var player_inventory: Array[Item] = []

var customer_queue: Array[Customer] = [] # Reference to the active customers at the counter

var customer_profiles: Dictionary = {} # id -> CustomerProfile

signal coins_changed(new_amount: int)

func restock():
	shop_balls = ItemDatabase.Balls.duplicate()
	shop_racquets = ItemDatabase.Racquets.duplicate()
	shop_bags = ItemDatabase.Bags.duplicate()
	shop_shoes = ItemDatabase.Shoes.duplicate()

func _ready():
	load_profiles()
	if player_inventory.is_empty():
		player_inventory = ItemDatabase.all_items.duplicate()
	
func save_profiles() -> void:
	var data = {}
	for id in customer_profiles:
		var profile = customer_profiles[id]
		data[id] = { # sets up the customer with the data they need to work in the game
			"id": profile.id,
			"customer_name": profile.customer_name,
			"personality": profile.personality,
			"owned_items": profile.owned_items
		}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	
func load_profiles() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	for id in parsed:
		var d = parsed[id]
		var profile = CustomerProfile.new()
		profile.id = d["id"]
		profile.customer_name = d["customer_name"]
		profile.personality = d["personality"]
		profile.owned_items.assign(d["owned_items"])
		customer_profiles[id] = profile
		
func get_or_create_profile(id: String, customer_name: String, personality: String) -> CustomerProfile:
	if customer_profiles.has(id): # if the customer already exists, just get the profile that exists at that id
		return customer_profiles[id]
	var profile = CustomerProfile.new() # if the customer doesnt exist, we need to create a new customer instance with the given data
	profile.id = id
	profile.customer_name = customer_name
	profile.personality = personality
	customer_profiles[id] = profile
	return profile
	
func add_coins(amount: int) -> void:
	player_coins += amount
	coins_changed.emit(player_coins)
