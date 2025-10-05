extends CanvasLayer

func _process(delta: float) -> void:
	pass

func buy_laser() -> void:
	if Inventory.coins >= 10:
		Inventory.unlocked.append("laser")
		Inventory.coins -= 10
		$Successful.visible = true
		await get_tree().create_timer(2).timeout
		$Successful.visible = false
	else:
		$Failure.visible = true
		await get_tree().create_timer(2).timeout
		$Failure.visible = false
