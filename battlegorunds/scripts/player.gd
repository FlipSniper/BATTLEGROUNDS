extends CharacterBody2D
class_name Player

signal died

@onready var camera_remote_transform = $CameraRemoteTransfer
@onready var shoot_raycast = $ShootRaycast
@onready var shoot_sound = $ShootSound
@onready var laser_line = $LaserLine2D
@onready var animplayer = $AnimationPlayer

var speed = 300.0
var laser_on := false
var gun_on := true
var current_weapon = "gun"

func _ready():
	laser_line.visible = false

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("toggle_laser") and !laser_on and !animplayer.is_playing() and "laser" in Inventory.unlocked:
		laser_on = true
		laser_line.visible = true
		if current_weapon == "gun":
			gun_on = false
			current_weapon = "laser"
			animplayer.play_backwards("turn_laser_on")
			animplayer.play("turn_laser_on")
			
	if Input.is_action_just_pressed("toggle_gun") and !gun_on and !animplayer.is_playing() and "gun" in Inventory.unlocked:
		gun_on = true
		if current_weapon == "laser":
			animplayer.play_backwards("turn_laser_on")
			laser_line.visible = false
			laser_on = false
		gun_on = true
		current_weapon = "gun"
		animplayer.play("turn_gun_on")
		
	if Input.is_action_just_pressed("shoot") and gun_on:
		shoot_sound.play()
		var bullet_instance = preload("res://scenes/bullet.tscn").instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = shoot_raycast.global_position
		bullet_instance.direction = (get_global_mouse_position() - global_position).normalized()
		bullet_instance.player = self


	if shoot_raycast.is_colliding():
		var cp = shoot_raycast.get_collision_point()
		var local_cp = to_local(cp)
		laser_line.points[1] = local_cp
	else:
		laser_line.points[1] = Vector2(1000,0)
	
	if Input.is_action_just_pressed("shoot") and laser_on:
		if shoot_raycast.is_colliding():
			var collider = shoot_raycast.get_collider()
			shoot_sound.play()
			if collider is StaticBody2D:
				print("shot a box")
			elif collider is Enemy:
				collider.player = self
				collider.take_damage(1)

func _physics_process(delta: float) -> void:
	var move_dir = Vector2(Input.get_axis("move_left","move_right"),
	Input.get_axis("move_up","move_down"))
	
	if move_dir != Vector2.ZERO:
		velocity = speed * move_dir.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0 ,speed)
		velocity.y = move_toward(velocity.y, 0 ,speed)
	
	move_and_slide()

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Enemy:
		died.emit()
		queue_free()
