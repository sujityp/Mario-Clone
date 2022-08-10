extends KinematicBody2D

# Declare member variables here. Examples:
export (int) var speed = 100
var velocity = Vector2(speed, 0)
var direction = 1
var g = 1000
signal player_collision


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = speed * direction
	velocity.y += g * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		direction *= -1


func _on_StompDetector_body_entered(body: Node) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	if body.name == "Player":
		body.velocity.y = body.jump_speed
	queue_free()
