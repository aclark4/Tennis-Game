extends Resource
class_name Item


@export var item_name: String = ""
@export var item_type: String = "" # Types: "ball", "string", "grip", "racquet", "shoe"
@export var price: int = 0
@export var description: String = ""
@export var rarity: String = ""
@export var detail: String = ""

@export var texture: Texture2D

func setup(name: String, t: String, p: int, desc: String, r: String = "Common", d: String = "") -> Item:
	item_name = name
	item_type = t
	price = p
	description = desc
	rarity = r
	detail = d
	var path = "res://Items/" + item_type + "/" + item_name + ".png"
	# print("loading: ", path)
	texture = load(path)
	# print("texture result: ", texture)
	return self
	
	
	
