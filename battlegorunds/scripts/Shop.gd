extends CanvasLayer

@export var Default: CanvasLayer

func buy_laser() -> void:
	if Inventory.coins >= 10 and !("laser" in Inventory.unlocked):
		Inventory.unlocked.append("laser")
		Inventory.coins -= 10
		$Shop/Products/Laser/Successful.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Laser/Successful.visible = false
	else:
		$Shop/Products/Laser/Failure.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Laser/Failure.visible = false



func buy_damage_I() -> void:
	var player = get_tree().current_scene.get_node_or_null("Player")
	if Inventory.coins >= 5 and Default.potions_equipped.size() < 8:
		Inventory.coins -= 5
		$Shop/Products/Damage/Successful.visible = true
		Inventory.potions.append("Damage_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Damage/Successful.visible = false
	elif !Inventory.coins >= 5:
		$Shop/Products/Damage/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Damage/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < 8:
		$Shop/Products/Damage/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Damage/Failure_Potions.visible = false


func buy_speed_I() -> void:
	var player = get_tree().current_scene.get_node_or_null("Player")
	if Inventory.coins >= 8 and Default.potions_equipped.size() < 8:
		Inventory.coins -= 8
		$Shop/Products/Speed/Successful.visible = true
		Inventory.potions.append("Speed_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Speed/Successful.visible = false
	elif !Inventory.coins >= 8:
		$Shop/Products/Speed/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Speed/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < 8:
		$Shop/Products/Speed/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Speed/Failure_Potions.visible = false


func buy_Poison_I() -> void:
	var player = get_tree().current_scene.get_node_or_null("Player")
	if Inventory.coins >= 10 and Default.potions_equipped.size() < 8:
		Inventory.coins -= 10
		$Shop/Products/Poison/Successful.visible = true
		Inventory.potions.append("Poison_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Poison/Successful.visible = false
	elif !Inventory.coins >= 10:
		$Shop/Products/Poison/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Poison/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < 8:
		$Shop/Products/Poison/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Poison/Failure_Potions.visible = false
