extends CharacterBody2D

var animation_played = 1
@onready var _animated_sprite = $AnimatedSprite2D

func play_animation(name):
	_animated_sprite.play(name)
	
	
	
func attack():
	if Input.is_action_just_pressed("attack"):
		play_animation("attack")
		

func _physics_process(_delta):
	attack()
