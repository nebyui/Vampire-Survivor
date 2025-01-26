extends Node2D

const MOB_SCENE = preload("res://mob.tscn")

#func _ready() -> void:
	#for i in 5:
		#spawn_mob()


func spawn_mob():
	var new_mob = MOB_SCENE.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout() -> void:
	for i in 10:
		spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
