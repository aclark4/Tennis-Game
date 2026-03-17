extends Node
var all_items: Array[Item] = []
var items_by_type: Dictionary = {}



func _ready():
	_load_all_items()

func _load_all_items() -> void:
	var dir = DirAccess.open("res://Items/")
	dir.list_dir_begin()
	var folder = dir.get_next()
	while folder != "":
		if dir.current_is_dir() and not folder.begins_with("."):
			_load_folder("res://Items/" + folder + "/")
		folder = dir.get_next()
			
func _load_folder(path: String) -> void:
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if file.ends_with(".tres"):
			var item = load(path + file)
			if item is Item:
				all_items.append(item)
				if not items_by_type.has(item.item_type):
					items_by_type[item.item_type] = []
				items_by_type[item.item_type].append(item)
		file = dir.get_next()
	
func get_items_by_type(item_type: String) -> Array[Item]:
	var result: Array[Item] = []
	if items_by_type.has(item_type):
		result.assign(items_by_type[item_type])
	return result
