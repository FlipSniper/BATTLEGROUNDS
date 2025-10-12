extends Control
var prev_coin
var prev_health
func _ready() -> void:
	$Fade/AnimationPlayer.play_backwards("fade")
	await get_tree().create_timer(1).timeout
	$Fade/ColorRect.visible = false
	$Default/coins.text = "Coins: "+str(Inventory.coins)
	prev_coin = Inventory.coins
	$Default/health.text = "Health: "+str(Inventory.health)
	prev_coin = Inventory.coins
func _process(delta: float) -> void:
	if prev_coin != Inventory.coins:
		$Default/coins.text = "Coins: "+str(Inventory.coins)
		prev_coin = Inventory.coins
	if prev_health != Inventory.health:
		$Default/health.health = "Health: "+str(Inventory.health)
		prev_health = Inventory.health
