extends Control
var prev_coin
func _ready() -> void:
	$Fade/AnimationPlayer.play_backwards("fade")
	await get_tree().create_timer(1).timeout
	$Fade/ColorRect.visible = false
	$Default/Label.text = "Coins: "+str(Inventory.coins)
	prev_coin = Inventory.coins
func _process(delta: float) -> void:
	if prev_coin != Inventory.coins:
		$Default/Label.text = "Coins: "+str(Inventory.coins)
		prev_coin = Inventory.coins
