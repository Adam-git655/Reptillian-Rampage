extends Node2D

@onready var red_dragon_scene = preload("res://Scenes and Scripts/red_dragon.tscn")
@onready var red_dragon_scene_script = preload("res://Scenes and Scripts/red_dragon.gd")
@onready var snake_scene = preload("res://Scenes and Scripts/snake.tscn")
@onready var pirana_scene = preload("res://Scenes and Scripts/pirana.tscn")

var red_dragon = []
var pirana = []
var snake = []

func _ready() -> void:	
	randomize()
	for i in get_children():
		if i is Marker2D:
			if "River" in i.name:
				pirana.append(i)
			elif "Marker" in i.name:
				red_dragon.append(i)
			elif "Snake" in i.name:
				snake.append(i)
	
	Main.connect("new_wave", _on_new_wave)

func _on_red_dragon_spawn_timer_timeout() -> void:
	var red_dragons = get_tree().get_nodes_in_group("red_dragon")
	
	if Main.current_red_dragons < Main.max_red_dragons:
		
		var spawn = red_dragon[randi() % red_dragon.size()]
		
		var red_dragon_instance = red_dragon_scene.instantiate()
		red_dragon_instance.position = spawn.position
		get_tree().get_current_scene().get_node("Enemies").add_child(red_dragon_instance)
		red_dragon_instance.add_to_group("enemy")
		red_dragon_instance.add_to_group("red_dragon")
		Main.current_red_dragons += 1

		$RedDragonSpawnTimer.start()
		
func _on_pirana_spawn_timer_timeout() -> void:
	var piranas = get_tree().get_nodes_in_group("pirana")
	
	if Main.current_piranas < Main.max_piranas:
		for i in range(3):
			var spawn = pirana[randi() % pirana.size()]
			
			var pirana_instance = pirana_scene.instantiate()
			pirana_instance.position = spawn.position
			get_tree().get_current_scene().get_node("Enemies").add_child(pirana_instance)
			pirana_instance.add_to_group("enemy")
			pirana_instance.add_to_group("pirana")
			Main.current_piranas += 1
			if Main.current_piranas >= Main.max_piranas:
				break
		
		$PiranaSpawnTimer.start()
		
func _on_snake_spawn_timer_timeout() -> void:
	var snakes = get_tree().get_nodes_in_group("snake")
	
	if Main.current_snakes < Main.max_snakes:
		var spawn = snake[randi() % snake.size()]
		
		var snake_instance = snake_scene.instantiate()
		snake_instance.position = spawn.position
		get_tree().get_current_scene().get_node("Enemies").add_child(snake_instance)
		snake_instance.add_to_group("enemy")
		snake_instance.add_to_group("snake")
		Main.current_snakes += 1

		$SnakeSpawnTimer.start()

func _on_new_wave():
	$RedDragonSpawnTimer.wait_time -= (10/100 * $RedDragonSpawnTimer.wait_time)
	$SnakeSpawnTimer.wait_time -= (10/100 * $SnakeSpawnTimer.wait_time)
	$PiranaSpawnTimer.wait_time -= (10/100 * $PiranaSpawnTimer.wait_time)
	
	$RedDragonSpawnTimer.start()
	$PiranaSpawnTimer.start()
	$SnakeSpawnTimer.start()
