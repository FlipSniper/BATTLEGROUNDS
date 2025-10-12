extends CharacterBody2D
class_name Player

signal died

@onready var camera_remote_transform = $CameraRemoteTransfer
@onready var shoot_raycast = $ShootRaycast
@onready var shoot_sound = $ShootSound
@onready var fire_sound = $FireSound
@onready var laser_line = $LaserLine2D
@onready var animplayer = $AnimationPlayer
@onready var hurt_sound = $HurtSound
var damage = 1

var speed = 300.0
var laser_on := false
var gun_on := true
var current_weapon = "gun"
var poison  =  0
var ticks = 0
var fire_on := false
var shoot_cooldown := 0.5
var time_since_last_shot := 0.0

func _ready():
	Inventory.health = 5
	laser_line.visible = false

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	time_since_last_shot += delta

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("toggle_laser") and !laser_on and !animplayer.is_playing() and "laser" in Inventory.unlocked:
		laser_on = true
		laser_line.visible = true
		if current_weapon == "gun":
			gun_on = false
			animplayer.play_backwards("turn_laser_on")
		if current_weapon == "fire":
			animplayer.play_backwards("turn_fire_on")
			$fire.visible = false
			fire_on = false
		animplayer.play("turn_laser_on")
		current_weapon = "laser"

	if Input.is_action_just_pressed("toggle_gun") and !gun_on and !animplayer.is_playing() and "gun" in Inventory.unlocked:
		gun_on = true
		if current_weapon == "laser":
			animplayer.play_backwards("turn_laser_on")
			laser_line.visible = false
			laser_on = false
		if current_weapon == "fire":
			animplayer.play_backwards("turn_fire_on")
			$fire.visible = false
			fire_on = false
		current_weapon = "gun"
		animplayer.play("turn_gun_on")
	if Input.is_action_just_pressed("fire") and !fire_on and !animplayer.is_playing() and "fire" in Inventory.unlocked:
		if current_weapon == "laser":
			animplayer.play_backwards("turn_laser_on")
			laser_line.visible = false
			laser_on = false
		if current_weapon == "gun":
			gun_on = false
			animplayer.play_backwards("turn_laser_on")
		$fire.visible = true
		fire_on = true
		current_weapon = "fire"
		animplayer.play("turn_gun_on")

	if Input.is_action_pressed("shoot") and gun_on and time_since_last_shot >= shoot_cooldown:
		print(damage)
		time_since_last_shot = 0.0
		shoot_sound.play()
		var bullet_instance = preload("res://scenes/bullet.tscn").instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = shoot_raycast.global_position
		bullet_instance.direction = (get_global_mouse_position() - global_position).normalized()
		bullet_instance.shooter = self
		bullet_instance.owner_type = "player"
		bullet_instance.poison = poison
		bullet_instance.ticks = ticks
	if Input.is_action_pressed("shoot") and fire_on and time_since_last_shot >= shoot_cooldown:
		print(damage)
		time_since_last_shot = 0.0
		fire_sound.play()
		animplayer.play("fire_attack")

	if shoot_raycast.is_colliding():
		var cp = shoot_raycast.get_collision_point()
		var local_cp = to_local(cp)
		laser_line.points[1] = local_cp
	else:
		laser_line.points[1] = Vector2(1000, 0)

	if Input.is_action_pressed("shoot") and laser_on and time_since_last_shot >= shoot_cooldown:
		time_since_last_shot = 0.0
		if shoot_raycast.is_colliding():
			var collider = shoot_raycast.get_collider()
			shoot_sound.play()
			if collider is StaticBody2D:
				print("shot a box")
			elif collider is Enemy:
				collider.player = self
				collider.take_damage(damage,poison,ticks)
	if Inventory.potions.size() != 0:
		for i in range(0,Inventory.potions.size()):
			print(Inventory.potions)
			var potion = Inventory.potions[i]
			for j in range(0,Inventory.potions.size()):
				if potion == Inventory.potions[j]:
					if potion == "Damage_I":
						damage+=1
						$UI/Default.potion("Damage_I")
						Inventory.potions.remove_at(i)
						print(Inventory.potions)
						start_timer("Damage_I",60,1)
					if potion == "Speed_I":
						speed += 50
						$UI/Default.potion("Speed_I")
						Inventory.potions.remove_at(i)
						print(Inventory.potions)
						start_timer("Speed_I",60,50)
					if potion == "Poison_I":
						poison += 1
						ticks += 1
						$UI/Default.potion("Poison_I")
						Inventory.potions.remove_at(i)
						print(Inventory.potions)
						start_timer("Poison_I",30,1)
					if potion == "Health_I":
						Inventory.health += 5
						$UI/Default.potion("Health_I")
						Inventory.potions.remove_at(i)
						print(Inventory.potions)
						start_timer("Health_I",30,1)
					if potion == "Potion_I":
						Inventory.potions_max+=12
						$UI/Default.potion("Potion_I")
						Inventory.potions.remove_at(i)
						print(Inventory.potions)
						start_timer("Health_I",120,12)
					if potion == "Discount_I":
						Inventory.discount+=.5
						$UI/Default.potion("Discount_I")
						Inventory.potions.remove_at(i)
						print(Inventory.potions)
						start_timer("Discount_I",240,.50)
					if potion == "Multiplier_I":
						Inventory.coin_multi+=1
						$UI/Default.potion("Clone_I")
						Inventory.potions.remove_at(i)
						print(Inventory.potions)
						start_timer("Multiplier",210,1)
func _physics_process(delta: float) -> void:
	var move_dir = Vector2(Input.get_axis("move_left", "move_right"),
	Input.get_axis("move_up", "move_down"))

	if move_dir != Vector2.ZERO:
		velocity = speed * move_dir.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()

func start_timer(name, time, attribute_sub):
	await get_tree().create_timer(time).timeout
	if name == "Damage_I":
		damage-=attribute_sub
		$UI/Default.potion_disable("Damage_I")
	if name == "Speed_I":
		speed-=	attribute_sub
		$UI/Default.potion_disable("Speed_I")
	if name == "Poison_I":
		poison-=attribute_sub
		ticks -= attribute_sub
		$UI/Default.potion_disable("Poison_I")
	if name == "Health_I":
		$UI/Default.potion_disable("Health_I")
	if name == "Potion_I":
		Inventory.potions_max -= attribute_sub
		$UI/Default.potion_disable("Potion_I")
	if name == "Discount_I":
		Inventory.discount -= attribute_sub
		$UI/Default.potion_disable("Discount_I")
	if name == "Multiplier_I":
		Inventory.coin_multi -= attribute_sub
		$UI/Default.potion_disable("Clone_I")

func _on_hit_box_body_entered(body: Node2D,check = false) -> void:
	if body is Enemy or check:
		$UI/Fade/ColorRect.visible = true
		$UI/Fade/AnimationPlayer.play("hurt")
		hurt_sound.play()
		Inventory.health -= 1
		await get_tree().create_timer(.67).timeout
		$UI/Fade/ColorRect.visible = false
		if Inventory.health <= 0:
			died.emit()
			queue_free()


func fire_hit(body: Node2D) -> void:
	print(body is Enemy)
	if body is Enemy:
		print("here")
		body.take_damage(damage, poison, ticks)
