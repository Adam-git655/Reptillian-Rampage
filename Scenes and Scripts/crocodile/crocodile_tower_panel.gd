extends Panel

@onready var CrocodileTower = preload("res://Scenes and Scripts/crocodile/crocodile_tower.tscn")
@onready var reptiles_path = get_tree().get_current_scene().get_node("Reptiles")
var tower_price = 240

func _ready() -> void:
	$CrocIdle/TowerPrice.text = str(tower_price)
	
func _on_gui_input(event: InputEvent) -> void:
	if Main.scales >= tower_price:
		var TempCrocodileTower = CrocodileTower.instantiate()
		
		if event is InputEventMouseButton and event.button_mask == 1:
			#Left mouse Button Down
			add_child(TempCrocodileTower)
			TempCrocodileTower.global_position = get_global_mouse_position()
			TempCrocodileTower.process_mode = Node.PROCESS_MODE_DISABLED
			
		elif event is InputEventMouseMotion and event.button_mask == 1:
			#Left mouse button down drag
			if get_child_count() > 1:	
				get_child(1).global_position = get_global_mouse_position()
			
			var overlapping_towers = get_child(1).get_node("TowerDetectionArea").get_overlapping_bodies()
			for tower in overlapping_towers:
				if tower.is_in_group("enemy"):
					overlapping_towers.erase(tower)
			
			if is_point_in_collision_polygon(get_global_mouse_position(), get_tree().get_root().get_node("@Node2D@2/PlaceableArea/WaterArea1")) or is_point_in_collision_polygon(get_global_mouse_position(), get_tree().get_root().get_node("@Node2D@2/PlaceableArea/WaterArea2")):
				if overlapping_towers.size() >= 1:	
					get_child(1).get_node("VisibilityPlacementArea").modulate = Color(255, 0, 0, 0.3)
				else:
					get_child(1).get_node("VisibilityPlacementArea").modulate = Color(0, 255, 0, 0.3)
			else:
				get_child(1).get_node("VisibilityPlacementArea").modulate = Color(255, 0, 0, 0.3)
			
		elif event is InputEventMouseButton and event.button_mask == 0:
			
			if get_global_mouse_position().y >= 555 and get_global_mouse_position().x >= 955 and get_global_mouse_position().x <= 1050:
				if get_child_count() > 1:
					get_child(1).queue_free()
			else:
				if get_child_count() > 1:
					get_child(1).queue_free()
					
				if is_point_in_collision_polygon(get_global_mouse_position(), get_tree().get_root().get_node("@Node2D@2/PlaceableArea/WaterArea1")) or is_point_in_collision_polygon(get_global_mouse_position(), get_tree().get_root().get_node("@Node2D@2/PlaceableArea/WaterArea2")):
					var overlapping_towers = get_child(1).get_node("TowerDetectionArea").get_overlapping_bodies()
					for tower in overlapping_towers:
						if tower.is_in_group("enemy"):
							overlapping_towers.erase(tower)
					
					if overlapping_towers.size() < 1:
						reptiles_path.add_child(TempCrocodileTower)
						TempCrocodileTower.global_position = get_global_mouse_position()
						TempCrocodileTower.get_node("VisibilityPlacementArea").hide()
						Main.scales -= tower_price
						$CrocIdle/PlaceSoundEffect.play()
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()

func is_point_in_collision_polygon(point:Vector2, collision_polygon:CollisionPolygon2D):
	var polygon_points = collision_polygon.polygon
	
	var global_polygon_points = []
	for local_point in polygon_points:
		var global_point = collision_polygon.to_global(local_point)
		global_polygon_points.append(global_point)
		
	return Geometry2D.is_point_in_polygon(point, global_polygon_points)
