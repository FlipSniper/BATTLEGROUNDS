extends Area2D

var speed = 800
var direction = Vector2.ZERO
var player = null
var rotated = false

func _physics_process(delta):
	if !rotated and direction != Vector2.ZERO:
		rotation = direction.angle()
		rotated = true

	if direction != Vector2.ZERO:
		position += direction * speed * delta

	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _on_body_entered(body):
	if body is Enemy:
		if player != null:
			body.player = player
		body.take_damage(1)
	queue_free()
