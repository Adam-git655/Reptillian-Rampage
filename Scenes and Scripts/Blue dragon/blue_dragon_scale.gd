extends CharacterBody2D

var target 
var speed = 600
var PathName = ""
var damage

func _physics_process(delta: float) -> void:
	var EnemiesNode = get_tree().get_current_scene().get_node("Enemies")
	for i in EnemiesNode.get_child_count():
		if EnemiesNode.get_child(i).name == PathName:
			target = EnemiesNode.get_child(i).global_position
			
	velocity = global_position.direction_to(target) * speed
	look_at(target)
	move_and_slide()
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("snake") or body.is_in_group("pirana"):
		body.health -= damage
		queue_free()
	
