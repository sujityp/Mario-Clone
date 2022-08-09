extends KinematicBody2D


# Declare member variables here. Examples:
export (int) var speed = 100
var velocity = Vector2(speed, 0)
var direction = 1
var g = 1000


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
