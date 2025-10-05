extends Area2D

var speed = 800
var direction = Vector2.ZERO

func _ready():
	# Rotate to face the direction of travel
	if direction != Vector2.ZERO:
		rotation = direction.angle()

func _physics_process(delta):
	if direction != Vector2.ZERO:
		position += direction * speed * delta
	
	# Optional: delete if off-screen
	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _on_body_entered(body):
	if body is Enemy:
		body.take_damage(1)
	queue_free()
