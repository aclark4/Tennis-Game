extends Node2D

const MAX_BALL_SLOTS: int = 6
const MAX_RACQUET_SLOTS: int = 6
const MAX_SHOE_SLOTS: int = 4
const MAX_BAG_SLOTS: int = 4

@onready var item_panel: Panel = $Panel
@onready var name_label: Label = $Panel/VBoxContainer/NameLabel
@onready var rarity_label: Label = $Panel/VBoxContainer/RarityLabel
@onready var price_label: Label = $Panel/VBoxContainer/PriceLabel
@onready var desc_label: Label = $Panel/VBoxContainer/DescLabel

@onready var customer_drop_zone: Control = $CustomerDropZone

@onready var customer_sprite: Sprite2D = $Customer

var serving_customer: Customer = null
var currently_selling: bool = false

signal closed
signal item_sold(item: Item)

func _ready() -> void:
	if GameData.customer_queue.size() > 0:
		currently_selling = true
		serving_customer = GameData.customer_queue[0]
		
		if serving_customer.state == serving_customer.CustomerState.BEING_SERVED:
			print("SERVED CURRENTLY")
			customer_sprite.texture = serving_customer.profile.sprite
			customer_sprite.hframes = 2
			customer_sprite.vframes = 2
			customer_sprite.frame = 0
			customer_sprite.visible = true
		else:
			customer_sprite.visible = false
		
	if serving_customer != null:
		customer_drop_zone.active = true
	
	customer_drop_zone.item_dropped.connect(_on_item_received)
	customer_sprite.visible = false
	item_panel.visible = false
	# Ensure tooltip always renders on top of item slots
	item_panel.z_index = 100

	var item_slot_scene: PackedScene = preload("res://Scenes/ItemSlot/item_slot.tscn")

	var counts = {"Balls": 0, "Racquets": 0, "Bags": 0, "Shoes": 0}
	var limits = {"Balls": MAX_BALL_SLOTS, "Racquets": MAX_RACQUET_SLOTS, "Bags": MAX_BAG_SLOTS, "Shoes": MAX_SHOE_SLOTS}

	for item in GameData.player_inventory:
		var t = item.item_type
		if not counts.has(t):
			continue
		if counts[t] >= limits[t]:
			continue
		var slot = item_slot_scene.instantiate()
		var i = counts[t]
		match t:
			"Balls":    slot.position = Vector2(40 + i * 25, 85)
			"Racquets": slot.position = Vector2(208 + (i % 3) * 36, 95 + (i / 3) * 55)
			"Bags":     slot.position = Vector2(50 + i * 40, 152)
			"Shoes":    slot.position = Vector2(45 + i * 40, 114)
		add_child(slot)
		slot.setup(item, i)
		slot.position -= slot.size / 2.0
		counts[t] += 1
	
	if GameData.customer_queue.size() > 0: # This means there is a customer waiting
		currently_selling = true
		if serving_customer.state == serving_customer.CustomerState.BEING_SERVED:
			print("SERVED CURRENTLY: SHOW SPRITE")
			customer_sprite.frame = 0
			customer_sprite.visible = true
		else:
			customer_sprite.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and !currently_selling:
		emit_signal("closed")
		queue_free()

func _on_item_received(item: Item) -> void:
	if serving_customer == null:
		return
	GameData.add_coins(item.price)
	serving_customer.receive_item(item)
	item_sold.emit(item)
	currently_selling = false
	closed.emit()
	customer_sprite.frame = 2
	queue_free()
