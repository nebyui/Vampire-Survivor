extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
var direction
var health = 2
var speed = 300
var mob_upgrade_chance
const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")

func _ready() -> void:
	#player = get_node("/root/Game/Player")
	%Slime.play_walk()
	mob_upgrade_chance = randi_range(1, 20)
	

	
	if mob_upgrade_chance == 20:
		health = 5
		speed = 700
		$Slime/%SlimeBodyHurt.modulate = Color(1, 0.9, 0.7, 0)
		$Slime/%SlimeBody.self_modulate = Color(0.8, 0.8, 0.8, 1)
		$Slime/%SlimeFace.modulate = Color(1, 1, 1, 1)
	elif mob_upgrade_chance == 1:
		health = 25
		scale = Vector2(2, 2)
		$Slime/%SlimeBodyHurt.modulate = Color(1, 0.9, 0.7, 0)
		$Slime/%SlimeBody.self_modulate = Color(0.3, 0.3, 0.9, 1)
		$Slime/%SlimeFace.modulate = Color(.9, .9, 0, 1)
		
	elif mob_upgrade_chance >= 15:
		health = 5
		$Slime/%SlimeBodyHurt.modulate = Color(1, 0.9, 0.7, 0)
		$Slime/%SlimeBody.self_modulate = Color(1, 0.3, 0.3, 1)
		$Slime/%SlimeFace.modulate = Color(0, 0, 0, 1)
	else:
		$Slime/%SlimeBodyHurt.modulate = Color(1, 0.9, 0.7, 0)
		$Slime/%SlimeBody.self_modulate = Color(0.8, 1, 0, 1)
		$Slime/%SlimeFace.modulate = Color(0, 0.2, 0.1, 1)
	

func _physics_process(delta: float) -> void:
	direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage() -> void:
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		var smoke = SMOKE_SCENE.instantiate()
		smoke.global_position = global_position
		get_parent().add_child(smoke)
