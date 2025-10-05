extends CanvasLayer

func _process(delta: float) -> void:
	pass

func buy_laser() -> void:
	if Inventory.coins == 10:
		Inventory.unlocked.append("laser")
		$Successful.visible = true
