extends HBoxContainer

@onready var coins_label = $CoinAmount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins_label.text = str(GameData.player_coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
