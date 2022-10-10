extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_Player_player_hit() -> void:
	$Enemy.speed = 0
	$Enemy/AnimatedSprite.playing = false
	
