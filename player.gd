extends CharacterBody2D

var direction: Vector2
var happy_boo
var health: float = 100.0
const DAMAGE_RATE = 15
var overlapping_mobs
var rotation_temp
var max_joystick_value = 0.3

var machine_gun = preload("res://machine_gun.tscn")
var shotgun = preload("res://shotgun.tscn")

var current_gun = machine_gun.instantiate()

signal health_depleted

func _ready() -> void:
	happy_boo = get_node("HappyBoo")
	add_child(current_gun)
	current_gun.global_position = %GunMarker.global_position

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	#print(Input.get_action_strength("move_right"), ", ", Input.get_action_strength("move_down"), ", ", Input.get_action_strength("move_left"), ", ", Input.get_action_strength("move_up"))
	#print(direction)
	
	if direction.length() > max_joystick_value:
		max_joystick_value = direction.length()
	
	
	velocity = 600 * (direction / max_joystick_value)
	print(velocity)
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0:
			health_depleted.emit()
			
	if Input.is_action_just_pressed("swap_gun"):
		swap_gun()
	
func swap_gun():
	rotation_temp = current_gun.global_rotation
	if current_gun.name == "MachineGun":
		current_gun.queue_free()
		current_gun = shotgun.instantiate()
	elif current_gun.name == "Shotgun":
		current_gun.queue_free()
		current_gun = machine_gun.instantiate()
		
	add_child(current_gun)
	current_gun.global_position = %GunMarker.global_position
	current_gun.global_rotation = rotation_temp
	
