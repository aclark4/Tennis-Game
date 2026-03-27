extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var nextDayButton: Button = $NextDayButton/NextDayButton

signal make_player_platformer()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nextDayButton.visible = false
	emit_signal("make_player_platformer")
	player.position = GameData.player_position


func _on_next_day_button_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/main_scene.tscn")


func _on_area_2d_area_entered(area: Area2D) -> void:
	nextDayButton.visible = true
