extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var anim_player = $ColorRect/AnimationPlayer


func _ready() -> void:
	color_rect.modulate.a = 0.0 # This sets it to start as fully transparent

func change_scene(path: String):
	fade_out()
	await anim_player.animation_finished
	get_tree().change_scene_to_file(path)
	fade_in()
	
func fade_out():
	anim_player.play("fade_out")


func fade_in():
	anim_player.play("fade_in")
