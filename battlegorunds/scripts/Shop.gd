extends CanvasLayer

func _process(delta: float) -> void:
	pass

func buy_laser() -> void:
	if Inventory.coins >= 10 and "laser" in Inventory.unlocked:
		Inventory.unlocked.append("laser")
		Inventory.coins -= 10
		$Laser/Successful.visible = true
		await get_tree().create_timer(2).timeout
		$Laser/Successful.visible = false
	else:
		$Laser/Failure.visible = true
		await get_tree().create_timer(2).timeout
		$Laser/Failure.visible = false
