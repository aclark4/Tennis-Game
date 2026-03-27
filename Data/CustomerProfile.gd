extends Resource
class_name CustomerProfile

@export var id: String = ""
@export var customer_name: String = ""
@export var personality: String = ""
@export var owned_items: Array[Item] = []
@export var sprite: Texture2D
@export var disliked_types: Array[String] = []
@export var impatient_time: int = 15
@export var priority: int = 0

func has_item(item: Item) -> bool:
	return item in owned_items
	
func add_item(item: Item) -> void:
	if not has_item(item):
		owned_items.append(item)

func dislikes_item(item: Item) -> void:
	if item.item_type in disliked_types:
		add_item(item)
		return
