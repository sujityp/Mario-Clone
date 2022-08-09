extends KinematicBody2D


# Declare member variables here. Examples:
export (int) var speed = 250
export (float) var acceleration = 0.3
export (float) var deceleration = 0.2
export (int) var jump_speed = -350
export (int) var g = 1000
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
	
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite.frame = 1


func process_movement(time):
	$AnimatedSprite.play("walk")
	if direction.x != 0:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		if direction.x < 0:
			$AnimatedSprite.flip_h = true
		elif direction.x > 0:
			$AnimatedSprite.flip_h = false
	else:
		velocity.x = lerp(velocity.x, 0, deceleration)
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0

	
	velocity.y += g * time
	velocity = move_and_slide(velocity, Vector2.UP)
	if direction.y == -1:
		if is_on_floor():
			velocity.y = jump_speed
	
	if not is_on_floor():
		$AnimatedSprite.stop()
		$AnimatedSprite.animation = "jump"
		if velocity.y <= 0:
			$AnimatedSprite.frame = 0
		else:
			$AnimatedSprite.frame = 1
	
