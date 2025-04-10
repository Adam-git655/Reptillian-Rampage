extends StaticBody2D

var dragon_scale = preload("res://Scenes and Scripts/Blue dragon/blue_dragon_scale.tscn")
var scale_damage = 50
var PathName
var currTargets = []
var curr


func _process(delta: float) -> void:
	check_overlaps()
	$AnimatedSprite2D.play("IdleFly")
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
		
		if $ScaleShootTimer.is_stopped():
			$ScaleShootTimer.start()
		
	else:
		$ScaleShootTimer.stop()
		for i in get_node("DragonScalesContainer").get_children():
			i.queue_free()

func shoot_scale():
	var temp_dragon_scale = dragon_scale.instantiate()
	temp_dragon_scale.PathName = PathName
	temp_dragon_scale.damage = scale_damage
	get_node("DragonScalesContainer").add_child(temp_dragon_scale)
	temp_dragon_scale.global_position = get_node("ScaleStartPoint").global_position
	$Shoot.play()
	
func _on_scale_shoot_timer_timeout() -> void:
	shoot_scale()

		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("snake") or body.is_in_group("pirana"):
		check_overlaps()
		
func check_overlaps():
	var TempArray = []
	currTargets = get_node("Area2D").get_overlapping_bodies()
	
	for i in currTargets:
		if i.is_in_group("snake") or i.is_in_group("pirana"):
			TempArray.append(i)
	
	var currTarget = null
	
	for i in TempArray:
		if currTarget == null:
			currTarget = i
		else:
			if i.position.x < currTarget.position.x:
				currTarget = i
				
	curr = currTarget
	if currTarget != null:
		PathName = currTarget.name
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("snake") or body.is_in_group("pirana"):
		check_overlaps()
