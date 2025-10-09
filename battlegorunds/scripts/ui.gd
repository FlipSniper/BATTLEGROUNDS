extends Control
var prev_coin
func _ready() -> void:
	$Default/Label.text = "Coins: "+str(Inventory.coins)
	prev_coin = Inventory.coins
func _process(delta: float) -> void:
	if prev_coin != Inventory.coins:
		$Default/Label.text = "Coins: "+str(Inventory.coins)
		prev_coin = Inventory.coins
