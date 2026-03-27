extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var nextDayButton: Button = $NextDayButton

signal make_player_platformer()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.position = GameData.player_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_end_day_button_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/main_scene.tscn")
