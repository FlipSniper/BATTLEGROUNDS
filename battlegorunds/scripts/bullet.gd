extends Area2D

var speed = 800
var direction = Vector2.ZERO
var rotated = false
var distance_travelled = 0.0
var max_distance = 500.0

var poison: int
var ticks: int
var owner_type: String
var shooter = null

func _physics_process(delta):
	if !rotated and direction != Vector2.ZERO:
		rotation = direction.angle()
		rotated = true

	if direction != Vector2.ZERO:
		var move = direction * speed * delta
		position += move
		distance_travelled += move.length()

	if distance_travelled >= max_distance:
		queue_free()


func _on_body_entered(body):
	print(body is Player)
	if owner_type == "player" and body is Enemy:
		print("here")
		body.take_damage(shooter.damage, poison, ticks)
		queue_free()
	elif owner_type == "enemy" and body is Player:
		print("here_L")
		body._on_hit_box_body_entered(null,true)
		queue_free()
	elif body is StaticBody2D:
		queue_free()
