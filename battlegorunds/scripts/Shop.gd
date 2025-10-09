extends CanvasLayer



func buy_laser() -> void:
	if Inventory.coins >= 10 and !("laser" in Inventory.unlocked):
		Inventory.unlocked.append("laser")
		Inventory.coins -= 10
		$Laser/Successful.visible = true
		await get_tree().create_timer(2).timeout
		$Laser/Successful.visible = false
	else:
		$Laser/Failure.visible = true
		await get_tree().create_timer(2).timeout
		$Laser/Failure.visible = false



func buy_damage() -> void:
	var player = get_tree().current_scene.get_node_or_null("Player")
	if Inventory.coins >= 5:
		player.damage += 1
		Inventory.coins -= 5
		$Damage/Successful.visible = true
		await get_tree().create_timer(2).timeout
		$Damage/Successful.visible = false
		await get_tree().create_timer(60).timeout
		print("affects = byebye")
		player.damage = 1
	else:
		$Damage/Failure.visible = true
		await get_tree().create_timer(2).timeout
		$Damage/Failure.visible = false
