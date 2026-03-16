extends Node
var Balls: Array[Item] = []
var Racquets: Array[Item] = []
var Bags: Array[Item] = []
var Shoes: Array[Item] = []


func _ready():
	
	Balls = [
		Item.new().setup("Standard Ball", "Balls", 4, "A classic tennis ball"),
		Item.new().setup("Slow Ball", "Balls", 5, "A slower tennis ball, for beginners"),
		Item.new().setup("Blue Ball", "Balls", 6, "A classic tennis ball, but BLUE!"),
		Item.new().setup("Pink Ball", "Balls", 6, "A classic tennis ball, but PINK!"),
		Item.new().setup("Flower Ball", "Balls", 7, "A beautiful floral ball"),
		Item.new().setup("Fire Ball", "Balls", 7, "A firey hot ball"),
		Item.new().setup("Rainbow Ball", "Balls", 7, "A beautiful and colorful ball"),
	]
	Racquets = [
		Item.new().setup("Standard Racquet", "Racquets", 100, "A standard tennis rackquet"),
		Item.new().setup("Fire Racquet", "Racquets", 120, "A flaming tennis rackquet"),
		Item.new().setup("Ice Racquet", "Racquets", 140, "An ice cool tennis rackquet"),
		Item.new().setup("Blue-Green Racquet", "Racquets", 110, "An stunning stripeda tennis rackquet"),
		Item.new().setup("Ice Cream Racquet", "Racquets", 120, "An tasty tennis rackquet"),
		Item.new().setup("Rainbow Racquet", "Racquets", 115, "An colorful tennis rackquet"),
	]
	Bags = [
		Item.new().setup("Standard Bag", "Bags", 69, "A standard tennis bag"),
		Item.new().setup("Matcha Bag", "Bags", 69, "A standard tennis bag"),
		Item.new().setup("Purple Ombre", "Bags", 69, "A standard tennis bag"),
		Item.new().setup("Pink Tote Bag", "Bags", 69, "A standard tennis bag", "Common", "Tote"),
		
	]
	Shoes = [
		Item.new().setup("Standard Shoes", "Shoes", 100, "Standard tennis shoes"),
		Item.new().setup("Speed Shoes", "Shoes", 150, "Speed boosting tennis shoes!"),
	]
	
func get_items_by_type(item_type: String) -> Array[Item]:
	match item_type:
		"Balls": return Balls
		"Racquets": return Racquets
		"Bags": return Bags
		"Shoes": return Shoes
		_: return []
