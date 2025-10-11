extends CanvasLayer

@onready var potion_list = $"Potion Counter/PotionList"
@onready var shop = $"../Shop"

var potions_equipped: Array = []
const MAX_POTIONS = 8


func _on_button_pressed() -> void:
	shop.visible = !shop.visible


func potion(name: String) -> void:
	if potions_equipped.size() >= MAX_POTIONS:
		push_warning("No empty potion slots available!")
		return

	potions_equipped.append(name)

	var label = Label.new()
	label.text = name
	potion_list.add_child(label)

	await get_tree().process_frame
	var scroll = potion_list.get_parent()
	if scroll is ScrollContainer:
		scroll.scroll_vertical = scroll.get_v_scroll_bar().max_value


func potion_disable(name: String) -> void:
	for child in potion_list.get_children():
		if child.text == name:
			child.queue_free()
			potions_equipped.erase(name)
			return
	push_warning("Potion not found: " + name)
