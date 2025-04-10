extends StaticBody2D

var scale_damage = 200
var PathName
var currTargets = []
var curr
var is_attacking = false

func _ready() -> void:
	for scale in $Scales.get_children():
		scale.hide()

func _process(delta: float) -> void:
	if !is_attacking:
		$AnimatedSprite2D.play("Idle")
	
	if is_instance_valid(curr):
		if $AttackTimer.is_stopped():
			print("hi")
			$AttackTimer.start()
			$"Pre-AttackCircle".start()
			
	for target in currTargets:
		if is_instance_valid(target):
			if !target.is_in_group("enemy"):
				currTargets.erase(target)
		
func check_overlaps():
	var TempArray = []
	currTargets = get_node("Area2D").get_overlapping_bodies()
	
	for i in currTargets:
		if i.is_in_group("enemy"):
			TempArray.append(i)
	
	var currTarget = null
	
	for i in TempArray:
		if currTarget == null:
			currTarget = i
		else:
			if i.position.x < currTarget.position.x:
				currTarget = i
				
	curr = currTarget


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("red_dragon") or body.is_in_group("snake"):
		check_overlaps()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("red_dragon") or body.is_in_group("snake"):
		check_overlaps()


func _on_attack_timer_timeout() -> void:
	attack()

func attack():
	is_attacking = true
	$AnimatedSprite2D.play("Attack")
	$AttackSound.play()
	
	for target in currTargets:
		if is_instance_valid(target) and !target.is_in_group("DragonsLair") and !target.is_in_group("pirana"):
			target.health -= scale_damage
			
	for scale in $Scales.get_children():
		scale.show()
	await get_tree().create_timer(1).timeout
	for scale in $Scales.get_children():
		scale.hide()			
	$VisibilityPlacementArea.hide()

func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false


func _on_pre_attack_circle_timeout() -> void:
	$VisibilityPlacementArea.show()
	$VisibilityPlacementArea.modulate = lerp(Color(255, 0, 0, 0), Color(255, 0, 0, 0.4), 0.4)
