extends Area2D

var enemies_in_range
var target_enemy
var random_rotation

# Modifications
var fire_rate: float = 0.8
var fire_counter: float = 0.8
const BULLET = preload("res://shot.tscn")


func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if fire_counter >= fire_rate:
			fire_counter = 0
			shoot()
	if fire_counter < fire_rate:
		fire_counter += delta
			



func _physics_process(delta: float) -> void:
	#enemies_in_range = get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
		#target_enemy = enemies_in_range.front()
		#look_at(get_global_mouse_position())
	look_at(get_global_mouse_position())

func shoot():
	for i in 12:
		random_rotation = randf_range(-0.2, 0.2)
		var bullet_instance = BULLET.instantiate()
		bullet_instance.global_position = %GunBarrel.global_position
		bullet_instance.global_rotation = %GunBarrel.global_rotation + random_rotation
		%GunBarrel.add_child(bullet_instance)

#func _on_timer_timeout() -> void:
	#shoot()
	#$Timer.wait_time
