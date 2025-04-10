extends Control


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_back_to_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes and Scripts/main_menu.tscn")
