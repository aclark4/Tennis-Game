extends Node

var player_position: Vector2 = Vector2(147,137)

var shop_balls: Array = []
var shop_racquets: Array = []
var shop_bags: Array = []
var shop_shoes: Array = []
var player_coins: int = 0

var customer_queue: Array = [] # Reference to the active customers at the counter



func restock():
	shop_balls = ItemDatabase.Balls.duplicate()
	shop_racquets = ItemDatabase.Racquets.duplicate()
	shop_bags = ItemDatabase.Bags.duplicate()
	shop_shoes = ItemDatabase.Shoes.duplicate()

func _ready():
	restock()
