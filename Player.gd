extends KinematicBody2D


# Declare member variables here. Examples:
export (int) var speed = 200
export (float) var acceleration = 0.3
export (float) var deceleration = 0.2
export (int) var jump_speed = -300
export (int) var g = 900
var velocity = Vector2.ZERO
var direction = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	get_input()
	process_movement(delta)


# Gets the user's input
func get_input():
	direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction.x += -1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.y += -1


func process_movement(time):
	if direction.x != 0:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, deceleration)
	
	velocity.y += g * time
	velocity = move_and_slide(velocity, Vector2.UP)
	if direction.y == -1:
		if is_on_floor():
			velocity.y = jump_speed
