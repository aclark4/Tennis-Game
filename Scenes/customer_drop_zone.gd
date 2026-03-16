extends Control


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Item
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var inventory = get_parent().get_parent()
	inventory._on_item_selected(data)
