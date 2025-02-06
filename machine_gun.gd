extends Area2D

var enemies_in_range
var target_enemy
var random_rotation
var aim_rotation

# Modifications
var fire_rate: float = 0.03
var fire_counter: float = 0.0
const BULLET = preload("res://bullet.tscn")


func _process(delta: float) -> void:
	
	aim_rotation = Input.get_vector("right_stick_up", "right_stick_down", "right_stick_left", "right_stick_right")
	
	
	if Input.is_action_pressed("shoot"):
		if fire_counter >= fire_rate:
			fire_counter = 0
			shoot()
		else:
			fire_counter += delta
			
	if aim_rotation.length() > 0.1:
		rotation = atan2(aim_rotation.x, aim_rotation.y)

func _physics_process(delta: float) -> void:
	#enemies_in_range = get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
		#target_enemy = enemies_in_range.front()
		#look_at(get_global_mouse_position())
	#look_at(get_global_mouse_position())
	pass
	
	

func shoot():
		var bullet_instance = BULLET.instantiate()
		random_rotation = randf_range(-0.05, 0.05)
		bullet_instance.global_position = %GunBarrel.global_position
		bullet_instance.global_rotation = %GunBarrel.global_rotation + random_rotation
		%GunBarrel.add_child(bullet_instance)

#func _on_timer_timeout() -> void:
	#shoot()
	#$Timer.wait_time
