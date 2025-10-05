extends Node2D

@export var enemy: PackedScene
var random

func spawn():
	random = randi_range(1, 32)
	var spawn_no = "spawn" + str(random)

	var spawn_point = get_node(spawn_no)
	
	var e = enemy.instantiate()
	get_tree().current_scene.call_deferred("add_child", e)
	e.global_position = spawn_point.global_position

	print("Spawned enemy at " + spawn_no)
