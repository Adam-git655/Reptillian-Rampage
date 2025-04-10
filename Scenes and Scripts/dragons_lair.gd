extends StaticBody2D

var health = 1000
var is_game_over = false
func _ready() -> void:
	health = 1000
	is_game_over = false

func _process(delta: float) -> void:
	Main.lair_health = health
	if health <= 0 and !is_game_over:
		is_game_over = true
		get_tree().change_scene_to_file("res://Scenes and Scripts/lose_menu.tscn")
