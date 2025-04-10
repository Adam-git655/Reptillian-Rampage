extends CharacterBody2D
var health = 150
var speed = 1.5
var dragon_lair_damage = 30
var is_attacking_lair = false
var DragonLair = null

func _ready() -> void:
	show()
	if Main.wave == 1:
		health = 150
		speed = 1.5
	elif Main.wave == 2:
		health = 190
		speed = 1.75
	elif Main.wave == 3:
		health = 220
		speed = 2
	elif Main.wave == 4:
		health = 250
		speed = 2.25
	elif Main.wave == 5:
		health = 280
		speed = 2.5

func _physics_process(delta: float) -> void:
	if $Chomp.playing == false:
		$Chomp.play()
	if !is_attacking_lair:
		position.x -= speed
		$AnimatedSprite2D.play("MoveLeft")
	
	if health <= 0:
		queue_free()
		Main.scales += 15
		
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("DragonsLair"):
		is_attacking_lair = true
		DragonLair = body
		$LairAttackCooldown.start()

func _on_lair_attack_cooldown_timeout() -> void:
	DragonLair.health -= dragon_lair_damage
	$LairAttackCooldown.start()

