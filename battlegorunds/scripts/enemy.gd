extends CharacterBody2D
class_name Enemy

@onready var animplayer = $AnimationPlayer
@onready var hurt_sound = $HurtSound
@export var type: String
@onready var spawns = get_tree().current_scene.get_node("spawns")

var player: Player = null

var speed: float = 100.0
var direction := Vector2.ZERO
var stop_distance := 20.0
var spawn_pos

var hit_points : int
@onready var rng = RandomNumberGenerator.new()

@export var drop : PackedScene
@export var bullet_scene : PackedScene
var wait_shoot=true

func _ready() -> void:
	rng.randomize()
	var num = rng.randi_range(0, 100)
	hit_points = 10 if num > 94 else 6


func _process(delta: float) -> void:
	if player != null:
		look_at(player.global_position)
		if type == "Disperse" and wait_shoot:
			wait_shoot = false
			print("trying")
			_spawn_bullets()
			await get_tree().create_timer(1.2).timeout
			wait_shoot = true
		if type == "Ranged" and wait_shoot:
			wait_shoot = false
			shoot()


func _physics_process(delta: float) -> void:
	if player != null:
		var enemy_to_player = player.global_position - global_position
		if enemy_to_player.length() > stop_distance:
			direction = enemy_to_player.normalized()
		else:
			direction = Vector2.ZERO

		if direction != Vector2.ZERO:
			velocity = speed * direction.normalized()
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)

		move_and_slide()


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player and player == null:
		player = body


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player and player != null:
		player = null
		print(name + " lost the player")


func take_damage(amount: int, poison, ticks_left):
	if amount > 0:
		hit_points -= amount
		hurt_sound.play()
		animplayer.play("take_damage")
		spawn_pos = global_position

		if hit_points <= 0:
			
			if type == "Disperse" and bullet_scene:
				_spawn_bullets()
			
			for i in range(rng.randi_range(0,7*Inventory.coin_multi)):
				var drop_instance = drop.instantiate()
				drop_instance.global_position = spawn_pos
				drop_instance.global_position.x += rng.randi_range(50,-50)
				drop_instance.global_position.y += rng.randi_range(50,-50)
				get_tree().current_scene.add_child(drop_instance)
			

			spawns.spawn()
			print(name + " died")
			queue_free()

		if poison > 0 and ticks_left > 0:
			await get_tree().create_timer(1).timeout
			take_damage(poison, poison, ticks_left - 1)

func shoot():
	var bullet = bullet_scene.instantiate()
	var angle = deg_to_rad(90)
	bullet.direction = Vector2.RIGHT.rotated(angle)
	bullet.global_position = global_position
	bullet.owner_type = "enemy"
	bullet.shooter = self
	get_tree().current_scene.add_child(bullet)


func _spawn_bullets():
	for i in range(10):
		var bullet = bullet_scene.instantiate()
		var angle = deg_to_rad(i * 36)
		bullet.direction = Vector2.RIGHT.rotated(angle)
		bullet.global_position = global_position
		bullet.owner_type = "enemy"
		bullet.shooter = self
		get_tree().current_scene.add_child(bullet)


func stay_away(body: Node2D) -> void:
	look_at(player.global_position)


func away_you_go(body: Node2D) -> void:
	pass # Replace with function body.
