extends Control

var active: bool = false
signal item_dropped(item: Item)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return active and data is Item
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	print("Item dropped")
	emit_signal("item_dropped", data)
