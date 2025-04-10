extends CharacterBody2D
var health = 100
var dragon_lair_damage = 20
var is_attacking_lair = false
var DragonLair = null
var speed = 2.5

func _ready() -> void:
	show()
	if Main.wave == 1:
		health = 100
		speed = 2.5
	elif Main.wave == 2:
		health = 120
		speed = 3
	elif Main.wave == 3:
		health = 140
		speed = 3.5
	elif Main.wave == 4:
		health = 160
		speed = 4
	elif Main.wave == 5:
		health = 180
		speed = 4.5

func _physics_process(delta: float) -> void:
	if $Hiss.playing == false:
		$Hiss.play()
	if !is_attacking_lair:
		position.x -= speed
		$AnimatedSprite2D.play("MoveLeft")
		
	if health <= 0:
		queue_free()
		Main.scales += 10
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("DragonsLair"):
		is_attacking_lair = true
		DragonLair = body
		$LairAttackCooldown.start()


func _on_lair_attack_cooldown_timeout() -> void:
	$AnimatedSprite2D.play("attack")
	DragonLair.health -= dragon_lair_damage
	$LairAttackCooldown.start()

