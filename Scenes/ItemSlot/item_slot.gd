extends Control

@onready var item_panel = $Panel
@onready var name_label = $Panel/MarginContainer/Control/NameLabel
@onready var rarity_label = $Panel/MarginContainer/Control/RarityLabel
@onready var price_label = $Panel/MarginContainer/Control/PriceLabel
@onready var desc_label = $Panel/MarginContainer/Control/DescLabel

signal hovered(item: Item)
signal unhovered()

var item_data: Item
var bag_racquet_sprite: Sprite2D = null

@onready var sprite: Sprite2D = $Item

func _ready():
	item_panel.visible = false
	# mouse_filter = Control.MOUSE_FILTER_STOP # This means the slot detects the mouse
	# item_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# item_panel.get_node("MarginContainer").mouse_filter = Control.MOUSE_FILTER_IGNORE # The panel will not interfere
	# item_panel.get_node("MarginContainer/Control").mouse_filter = Control.MOUSE_FILTER_IGNORE # The panel will not interfere
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func _process(float):
	if item_panel.visible and item_data.item_type == "Racquets":
		# Offset slightly so the cursor doesn't overlap the panel
		item_panel.position = get_local_mouse_position() + Vector2(-item_panel.size.x, -item_panel.size.y / 2)
	elif item_panel.visible and item_data.item_type != "Racquets":
		item_panel.position = get_local_mouse_position() + Vector2(0, -item_panel.size.y / 2)

func setup(item: Item, slot_index: int = 0):
	item_data = item
	sprite.texture = item.texture
	var tex_size = Vector2(item.texture.get_width(), item.texture.get_height())
	size = tex_size
	# Center the sprite inside the control rect
	sprite.position = tex_size / 2.0
	
	if item_data.item_type == "Bags":
		var racquet = ItemDatabase.Racquets[slot_index]
		bag_racquet_sprite = Sprite2D.new()
		bag_racquet_sprite.texture = racquet.texture
		bag_racquet_sprite.position = tex_size / 2.0
		bag_racquet_sprite.flip_v = true
		
		if item_data.detail == "Tote":
			print("HERE")
			bag_racquet_sprite.rotation_degrees = -45
			bag_racquet_sprite.position.x -= 8
		add_child(bag_racquet_sprite)
		move_child(bag_racquet_sprite, 0)


func _on_mouse_entered() -> void:
	name_label.text = item_data.item_name
	rarity_label.text = "Rarity: " + item_data.rarity
	price_label.text = str(item_data.price)
	desc_label.text = item_data.description
	item_panel.visible = true
	emit_signal("hovered", self)


func _on_mouse_exited() -> void:
	emit_signal("unhovered")
	item_panel.visible = false
	
func _get_drag_data(at_position: Vector2) -> Variant:
	var tex_size = Vector2(item_data.texture.get_width(), item_data.texture.get_height())
	
	var wrapper = Control.new()
	
	var preview = TextureRect.new()
	preview.texture = item_data.texture
	preview.custom_minimum_size = tex_size
	preview.position = -tex_size/2.0
	wrapper.add_child(preview)
	set_drag_preview(wrapper)
	sprite.visible = false
	if bag_racquet_sprite:
		bag_racquet_sprite.visible = false
	return item_data
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			sprite.visible = true
			if bag_racquet_sprite:
				bag_racquet_sprite.visible = true
