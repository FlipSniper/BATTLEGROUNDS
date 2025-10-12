extends Node2D

@export var normal_enemy: PackedScene
@export var dispersed_enemy: PackedScene
@export var ranged_enemy: PackedScene
var random

func spawn():
	random = randi_range(1, 32)
	var spawn_no = "spawn" + str(random)

	var spawn_point = get_node(spawn_no)
	var num = RandomNumberGenerator.new().randi_range(0,100)
	if num > 67:
		var e = normal_enemy.instantiate()
		get_tree().current_scene.call_deferred("add_child", e)
		e.global_position = spawn_point.global_position
	elif num <34:
		var e = ranged_enemy.instantiate()
		get_tree().current_scene.call_deferred("add_child", e)
		e.global_position = spawn_point.global_position
		
	else:
		var e = dispersed_enemy.instantiate()
		get_tree().current_scene.call_deferred("add_child", e)
		e.global_position = spawn_point.global_position

	print("Spawned enemy at " + spawn_no)
