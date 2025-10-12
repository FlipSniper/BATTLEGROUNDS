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
	print(Inventory.discount)
	if Inventory.coins >= (5-Inventory.discount*5) and Default.potions_equipped.size() < Inventory.potions_max:
		Inventory.coins -= (5-Inventory.discount*5)
		$Shop/Products/Damage/Successful.visible = true
		Inventory.potions.append("Damage_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Damage/Successful.visible = false
	elif !Inventory.coins >= (5-Inventory.discount*5):
		$Shop/Products/Damage/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Damage/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < Inventory.potions_max:
		$Shop/Products/Damage/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Damage/Failure_Potions.visible = false


func buy_speed_I() -> void:
	if Inventory.coins >= (8-Inventory.discount*8) and Default.potions_equipped.size() < Inventory.potions_max:
		Inventory.coins -= (8-Inventory.discount*8)
		$Shop/Products/Speed/Successful.visible = true
		Inventory.potions.append("Speed_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Speed/Successful.visible = false
	elif !Inventory.coins >= (8-Inventory.discount*8):
		$Shop/Products/Speed/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Speed/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < Inventory.potions_max:
		$Shop/Products/Speed/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Speed/Failure_Potions.visible = false


func buy_Poison_I() -> void:
	if Inventory.coins >= (15-Inventory.discount*10) and Default.potions_equipped.size() < Inventory.potions_max:
		Inventory.coins -= (10-Inventory.discount*10)
		$Shop/Products/Poison/Successful.visible = true
		Inventory.potions.append("Poison_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Poison/Successful.visible = false
	elif !Inventory.coins >= (10-Inventory.discount*10):
		$Shop/Products/Poison/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Poison/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < Inventory.potions_max:
		$Shop/Products/Poison/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Poison/Failure_Potions.visible = false
func buy_Health_I() -> void:
	if Inventory.coins >= (15-Inventory.discount*15) and Default.potions_equipped.size() < Inventory.potions_max:
		Inventory.coins -= (15-Inventory.discount*15)
		$Shop/Products/Health/Successful.visible = true
		Inventory.potions.append("Health_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Health/Successful.visible = false
	elif !Inventory.coins >= (15-Inventory.discount*15):
		$Shop/Products/Health/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Health/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < Inventory.potions_max:
		$Shop/Products/Health/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Health/Failure_Potions.visible = false

func buy_Potion_I() -> void:
	if Inventory.coins >= (15-Inventory.discount*15) and Default.potions_equipped.size() < Inventory.potions_max:
		Inventory.coins -= (15-Inventory.discount*15)
		$Shop/Products/Health/Successful.visible = true
		Inventory.potions.append("Potion_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Potion/Successful.visible = false
	elif !Inventory.coins >= (15-Inventory.discount*15):
		$Shop/Products/Potion/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Potion/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < Inventory.potions_max:
		$Shop/Products/Potion/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Potion/Failure_Potions.visible = false

func buy_Discount_I() -> void:
	if Inventory.coins >= (25-Inventory.discount*25) and Default.potions_equipped.size() < Inventory.potions_max and Inventory.discount == 0:
		Inventory.coins -= (25-Inventory.discount*25)
		$Shop/Products/Discount/Successful.visible = true
		Inventory.potions.append("Discount_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Discount/Successful.visible = false
	elif !Inventory.coins >= (25-Inventory.discount*25):
		$Shop/Products/Discount/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Discount/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < Inventory.potions_max:
		$Shop/Products/Discount/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Discount/Failure_Potions.visible = false

func buy_Multiplier_I() -> void:
	if Inventory.coins >= (40-Inventory.discount*40) and Default.potions_equipped.size() < Inventory.potions_max:
		Inventory.coins -= (40-Inventory.discount*40)
		$Shop/Products/Discount/Successful.visible = true
		Inventory.potions.append("Multiplier_I")
		await get_tree().create_timer(2).timeout
		$Shop/Products/Discount/Successful.visible = false
	elif !Inventory.coins >= (40-Inventory.discount*40):
		$Shop/Products/Discount/Failure_Coins.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Discount/Failure_Coins.visible = false
	elif !Default.potions_equipped.size() < Inventory.potions_max:
		$Shop/Products/Discount/Failure_Potions.visible = true
		await get_tree().create_timer(2).timeout
		$Shop/Products/Discount/Failure_Potions.visible = false
