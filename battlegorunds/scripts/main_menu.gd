extends Control

@onready var buttons_anim = $Buttons/AnimationPlayer
@onready var background_anim = $Background/AnimationPlayer

func _ready() -> void:
	buttons_anim.play("buttons")
	background_anim.play("title")

func mouse_buttons() -> void:
	buttons_anim.play("RESET")


func mouse_buttons_exited() -> void:
	buttons_anim.play("buttons")


func play() -> void:
	$Fade/ColorRect.visible = true
	$Fade/AnimationPlayer.play("fade")
	await get_tree().create_timer(.9).timeout
	get_tree().change_scene_to_file("res://scenes/world.tscn")
