extends HBoxContainer

@onready var coins_label = $CoinAmount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins_label.text = str(GameData.player_coins)
	GameData.coins_changed.connect(_update_coins)

func _update_coins(coins: int) -> void:
	coins_label.text = str(coins)
