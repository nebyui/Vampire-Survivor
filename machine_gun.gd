extends Area2D

var enemies_in_range
var target_enemy
var random_rotation

# Modifications
var fire_rate: float = 0.03
var fire_counter: float = 0.0
const BULLET = preload("res://bullet.tscn")


func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if fire_counter >= fire_rate:
			fire_counter = 0
			shoot()
		else:
			fire_counter += delta


func _physics_process(delta: float) -> void:
	#enemies_in_range = get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
		#target_enemy = enemies_in_range.front()
		#look_at(get_global_mouse_position())
	look_at(get_global_mouse_position())

func shoot():
	for i in 6:
		var bullet_instance = BULLET.instantiate()
		random_rotation = randf_range(-0.1, 0.1)
		bullet_instance.global_position = %GunBarrel.global_position
		bullet_instance.global_rotation = %GunBarrel.global_rotation + random_rotation
		%GunBarrel.add_child(bullet_instance)

#func _on_timer_timeout() -> void:
	#shoot()
	#$Timer.wait_time
