extends KinematicBody2D


# Declare member variables here. Examples:
export (int) var speed = 250
export (float) var acceleration = 0.3
export (float) var deceleration = 0.2
export (int) var jump_speed = -350
export (int) var g = 1000
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
signal player_hit
var alive = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if alive: get_player_input()
	process_movement(delta)
	animate_player()


# Gets the user's input
func get_player_input():
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
	if direction.x != 0 and alive:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, deceleration)
	
	velocity.y += g * time
	velocity = move_and_slide(velocity, Vector2.UP)
	if direction.y == -1:
		if is_on_floor():
			velocity.y = jump_speed


func animate_player():
	if alive:
		$AnimatedSprite.play("walk")
		if direction.x < 0:
			$AnimatedSprite.flip_h = true
		elif direction.x > 0:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.stop()
			$AnimatedSprite.frame = 0
		
		if not is_on_floor():
			$AnimatedSprite.stop()
			$AnimatedSprite.animation = "jump"
			if velocity.y <= 0:
				$AnimatedSprite.frame = 0
			else:
				$AnimatedSprite.frame = 1
	else:
		pass


func _on_EnemyDetector_body_entered(body: Node) -> void:
	if body.is_in_group("Dangerous"):
		emit_signal("player_hit")
		kill_player()


func kill_player():
	alive = false
	$AnimatedSprite.animation = "death"
	$CollisionShape2D.queue_free()
	$EnemyDetector.queue_free()
	velocity = Vector2(0,1.125 * jump_speed)
	velocity = move_and_slide(velocity, Vector2.UP)
