extends Area2D

var speed = 800
var direction = Vector2.ZERO
var player = null
var rotated = false
var distance_travelled = 0.0
var max_distance = 500.0  # how far bullet can travel (in pixels)

func _physics_process(delta):
	if !rotated and direction != Vector2.ZERO:
		rotation = direction.angle()
		rotated = true

	if direction != Vector2.ZERO:
		var move = direction * speed * delta
		position += move
		distance_travelled += move.length()

	# delete bullet if it's gone too far
	if distance_travelled >= max_distance:
		queue_free()

func _on_body_entered(body):
	if body is Enemy:
		if player != null:
			body.player = player
		body.take_damage(1)
	queue_free()
