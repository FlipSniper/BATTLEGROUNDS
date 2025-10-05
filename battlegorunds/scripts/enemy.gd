extends CharacterBody2D
class_name Enemy

@onready var animplayer = $AnimationPlayer
@onready var hurt_sound = $HurtSound

var player: Player = null

var speed: float = 100.0
var direction:= Vector2.ZERO
var stop_distance := 20.0

var hit_points : int = 3

func _process(delta: float) -> void:
	if player != null:
		look_at(player.global_position)

func _physics_process(delta: float) -> void:
	if player != null:
		var enemy_to_player = (player.global_position - global_position)
		if enemy_to_player.length()> stop_distance:
			direction = enemy_to_player.normalized()
		else:
			direction = Vector2.ZERO
		
		if direction != Vector2.ZERO:
			velocity = speed * direction.normalized()
		else:
			velocity.x = move_toward(velocity.x, 0 ,speed)
			velocity.y = move_toward(velocity.y, 0 ,speed)
		
		move_and_slide()

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		if player == null:
			player = body
			print(name +" found the player")


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		if player != null:
			player = null
			print(name +" lost the player")

func take_damage(amount : int):
	if amount> 0:
		hit_points -= amount
		hurt_sound.play()
		animplayer.play("take_damage")
		if hit_points <= 0:
			print(name + " died")
			queue_free()
