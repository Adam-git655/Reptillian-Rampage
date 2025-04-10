extends CharacterBody2D
var health = 200
var dragon_lair_damage = 50
var dragon_lair_pos = Vector2(80, 357)
@export var speed = 110

var is_attacking_lair = false
var DragonLair = null

func _ready() -> void:
	show()
	if Main.wave == 1:
		health = 200
		speed = 110
	elif Main.wave == 2:
		health = 230
		speed = 130
	elif Main.wave == 3:
		health = 270
		speed = 150
	elif Main.wave == 4:
		health = 310
		speed = 170
	elif Main.wave == 5:
		health = 350
		speed = 200

func _physics_process(delta: float) -> void:
	if $GrowlSound.playing == false:
		$GrowlSound.play()
	$AnimatedSprite2D.play("MoveLeft")
	if !is_attacking_lair:
		velocity = global_position.direction_to(dragon_lair_pos) * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	
		
	if health <= 0:
		queue_free()
		Main.scales += 25

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("DragonsLair"):
		is_attacking_lair = true
		DragonLair = body
		$LairAttackCooldown.start()
		
func _on_lair_attack_cooldown_timeout() -> void:
	DragonLair.health -= dragon_lair_damage
	print("attacked")
	$LairAttackCooldown.start()

