extends CharacterBody2D

const speed = 50
@onready var _animated_sprite = $AnimatedSprite2D
var attacking = false
const JUMP_VELOCITY = -200.0


func play_animation(name):
	_animated_sprite.play(name)


func get_input():
	var input_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity.x = input_direction.x * speed
	if velocity.x==0:
		play_animation("default")
	else:
		play_animation("walk")
		if velocity.x < 0:
			_animated_sprite.flip_h = true
		else:
			_animated_sprite.flip_h = false
			
	
func attack():
	attacking = true
	play_animation("attack")
	attacking = false
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if attacking:
		return
	if Input.is_action_just_pressed("attack"):
		attack()
	else:
		get_input()
		move_and_slide()
	


func _on_enter_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_exit_area_body_shape_exited(body: Node2D) -> void:
	pass # Replace with function body.
