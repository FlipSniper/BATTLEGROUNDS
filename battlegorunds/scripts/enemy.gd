extends CharacterBody2D
class_name Enemy

var player: Player = null

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		if player == null:
			player = body
			print(name +" found the player")


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		if player != null:
			player = null
			print(name +" lost the player")
