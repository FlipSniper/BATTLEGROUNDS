extends CanvasLayer

@export var Default: CanvasLayer

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



func buy_damage_I() -> void:
	var player = get_tree().current_scene.get_node_or_null("Player")
	if Inventory.coins >= 5 and Default.potions_equipped.size() < 8:
		Inventory.coins -= 5
		$Damage/Successful.visible = true
		Inventory.potions.append("Damage_I")
		await get_tree().create_timer(2).timeout
		$Damage/Successful.visible = false
	elif !Inventory.coins >= 5:
		$Damage/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Damage/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < 8:
		$Damage/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Damage/Failure_Potions.visible = false


func buy_speed_I() -> void:
	var player = get_tree().current_scene.get_node_or_null("Player")
	if Inventory.coins >= 8 and Default.potions_equipped.size() < 8:
		Inventory.coins -= 8
		$Speed/Successful.visible = true
		Inventory.potions.append("Speed_I")
		await get_tree().create_timer(2).timeout
		$Speed/Successful.visible = false
	elif !Inventory.coins >= 8:
		$Speed/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Speed/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < 8:
		$Speed/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Speed/Failure_Potions.visible = false
