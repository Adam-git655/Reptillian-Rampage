extends StaticBody2D

var damage = 200
var currTargets = []
var curr = null
var scale_status_on = false
var upgrades_on = []

signal upgrade_gui_show_komodo(tower_upgrades, tower_scale)

func _ready() -> void:
	$Hitbox/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("Idle")
	
func _process(delta: float) -> void:
	check_overlaps()
	if is_instance_valid(curr):
		if $SlashAttackTimer.is_stopped():
			$SlashAttackTimer.start()
	else:
		$AnimatedSprite2D.stop()
		if !$SlashAttackTimer.is_stopped():
			$SlashAttackTimer.stop()
		
func slash_attack():
	if curr != null:
		self.look_at(curr.global_position)
	$AnimatedSprite2D.play("FurySlash")
	$Hitbox/CollisionShape2D.disabled = false
	check_overlaps()
	
func _on_slash_attack_timer_timeout() -> void:
	slash_attack()
	$Slash.play()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		check_overlaps()

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
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		check_overlaps()


func _on_animated_sprite_2d_animation_finished() -> void:
	$Hitbox/CollisionShape2D.disabled = true


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		await get_tree().create_timer(0.3).timeout
		$Hitbox/CollisionShape2D.disabled = true
		if is_instance_valid(body):
			body.health -= damage
		check_overlaps()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_mask == 1:
		emit_signal("upgrade_gui_show_komodo", upgrades_on, scale_status_on)
