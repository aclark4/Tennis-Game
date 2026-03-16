extends Resource
class_name CustomerProfile

@export var id: String = ""
@export var customer_name: String = ""
@export var personality: String = ""
@export var owned_items: Array[String] = []

func has_item(item_name: String) -> bool:
	return item_name in owned_items
	
func add_item(item_name: String) -> void:
	if not has_item(item_name):
		owned_items.append(item_name)
