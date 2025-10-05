extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print(body)
	print(body == Player)
	if body is Player:
		queue_free()
		Inventory.coins += 1
		print(Inventory.coins)
