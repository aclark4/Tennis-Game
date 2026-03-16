extends Node2D

const MAX_BALL_SLOTS: int = 6
const MAX_RACQUET_SLOTS: int = 6
const MAX_SHOE_SLOTS: int = 5
const MAX_BAG_SLOTS: int = 4

@onready var item_panel = $Panel
@onready var name_label = $Panel/VBoxContainer/NameLabel
@onready var rarity_label = $Panel/VBoxContainer/RarityLabel
@onready var price_label = $Panel/VBoxContainer/PriceLabel
@onready var desc_label = $Panel/VBoxContainer/DescLabel

@onready var customer_sprite: Sprite2D = $Customer

var currently_selling: bool = false

signal closed

func _ready() -> void:
	customer_sprite.visible = false
	item_panel.visible = false
	# Ensure tooltip always renders on top of item slots
	item_panel.z_index = 100

	var item_slot_scene = preload("res://Scenes/ItemSlot/item_slot.tscn")

	var balls: int = 0
	for item in GameData.shop_balls:
		if balls >= MAX_BALL_SLOTS:
			break
		var slot = item_slot_scene.instantiate()
		slot.position = Vector2(40 + balls * 25, 85)
		add_child(slot)
		slot.setup(item)
		slot.position -= slot.size / 2.0
		balls += 1

	var racquets: int = 0
	for item in GameData.shop_racquets:
		if racquets >= MAX_RACQUET_SLOTS:
			break
		var slot = item_slot_scene.instantiate()
		slot.position = Vector2(208 + (racquets % 3) * 36, 95 + (racquets / 3) * 55)
		add_child(slot)
		slot.setup(item)
		slot.position -= slot.size / 2.0
		racquets += 1

	var bags: int = 0
	for item in GameData.shop_bags:
		if bags >= MAX_BAG_SLOTS:
			break
		var slot = item_slot_scene.instantiate()
		slot.position = Vector2(50 + bags * 40, 152)
		add_child(slot)
		slot.setup(item, bags)
		slot.position -= slot.size / 2.0
		bags += 1

	var shoes: int = 0
	for item in GameData.shop_shoes:
		if shoes >= MAX_SHOE_SLOTS:
			break
		var slot = item_slot_scene.instantiate()
		slot.position = Vector2(45 + shoes * 50, 114)
		add_child(slot)
		slot.setup(item)
		slot.position -= slot.size / 2.0
		shoes += 1
	
	if GameData.customer_queue.size() > 0: # This means there is a customer waiting
		currently_selling = true
		var serving = GameData.customer_queue[0]
		if serving.state == serving.CustomerState.BEING_SERVED:
			print("SERVED CURRENTLY: SHOW SPRITE")
			customer_sprite.frame = 0
			customer_sprite.visible = true
		else:
			customer_sprite.visible = false
	


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and !currently_selling:
		emit_signal("closed")
		queue_free()
