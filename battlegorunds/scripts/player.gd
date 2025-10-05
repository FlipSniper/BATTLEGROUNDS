extends CharacterBody2D
class_name Player

signal died

@onready var camera_remote_transform = $CameraRemoteTransfer
@onready var shoot_raycast = $ShootRaycast
@onready var shoot_sound = $ShootSound
@onready var laser_line = $LaserLine2D

var speed = 300.0
var laser_on := false

func _ready():
	laser_line.visible = false

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("toggle_laser"):
		laser_on = true
		laser_line.visible = true
	
	if shoot_raycast.is_colliding():
		var cp = shoot_raycast.get_collision_point()
		var local_cp = to_local(cp)
		laser_line.points[1] = local_cp
	else:
		laser_line.points[1] = Vector2(1000,0)
	
	if Input.is_action_just_pressed("shoot"):
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

func take_damage():
	pass
