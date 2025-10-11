extends CanvasLayer



func _on_button_pressed() -> void:
	var shop = $"../Shop"
	shop.visible = !shop.visible

func _process(delta: float) -> void:
	pass
