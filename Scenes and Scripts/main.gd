extends Node2D
var max_red_dragons = 3
var max_piranas = 6
var max_snakes = 5
var wave = 1
var scales = 400
var lair_health = 1000
signal new_wave

var current_red_dragons = 0
var current_piranas = 0
var current_snakes = 0

func _ready() -> void: 
	max_red_dragons = 3
	max_piranas = 6
	max_snakes = 5
	wave = 1
	scales = 400
	lair_health = 1000
	current_red_dragons = 0
	current_piranas = 0
	current_snakes = 0
	
func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("enemy").size() == 0:
		next_wave_check()

func next_wave_check():
	
	if current_red_dragons == max_red_dragons and current_piranas == max_piranas and current_snakes == max_snakes:
		next_wave()

func next_wave():	
	current_red_dragons = 0
	current_piranas = 0
	current_snakes = 0
	wave += 1
	
	if wave == 6:
		get_tree().change_scene_to_file("res://Scenes and Scripts/win_menu.tscn")
		
	new_wave.emit()
	scales += 100
	await get_tree().create_timer(2).timeout
	
	if wave == 1:
		max_red_dragons = 3
		max_piranas = 7
		max_snakes = 5
	elif wave == 2:
		max_red_dragons = 5
		max_piranas = 11
		max_snakes = 8
	elif wave == 3:
		max_red_dragons = 7
		max_piranas = 15
		max_snakes = 11
	elif wave == 4:
		max_red_dragons = 9
		max_piranas = 19
		max_snakes = 14
	elif wave == 5:
		max_red_dragons = 11
		max_piranas = 23
		max_snakes = 17
	#elif wave == 6:
	#	max_red_dragons = 13
	#	max_piranas = 27
	#	max_snakes = 20
	#elif wave == 7:
	#	max_red_dragons = 15
	#	max_piranas = 31
	#	max_snakes = 23
	#elif wave == 8:
	#	max_red_dragons = 17
	#	max_piranas = 35
	#	max_snakes = 26
	#elif wave == 9:
	#	max_red_dragons = 19
	#	max_piranas = 39
	#	max_snakes = 29
	#elif wave == 10:
	#	max_red_dragons = 21
	#	max_piranas = 43
	#	max_snakes = 32
	
