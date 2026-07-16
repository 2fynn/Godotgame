extends CharacterBody2D

var speed = 50
@onready var _animated_sprite = $AnimatedSprite2D
var is_attacking = false
const JUMP_VELOCITY = -200.0
var follow_player :bool
var is_dead = false
var max_health: int = 30
var health: int = max_health


func play_animation(name):
	_animated_sprite.play(name)
	
func die():
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	set_physics_process(false)
	play_animation("death")
	await get_tree().create_timer(0.8).timeout
	get_tree().reload_current_scene()

func slowdown():
	speed = 10
	await get_tree().create_timer(2).timeout
	speed = 50
	
func bounce() -> void:
	velocity.y = -300  # Wert je nach Bedarf anpassen

func get_input():
	if is_attacking:
		return
	
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
	if Input.is_action_just_pressed("attack"):
		attack()




func attack():
	is_attacking = true
	play_animation("attack")
	$Attackarea.activate()
	
	await get_tree().create_timer(0.5).timeout  # Zeitpunkt, wann die Hitbox aktiv sein soll
	$Attackarea.deactivate()
	
	await get_tree().create_timer(0.3).timeout  # Rest der Animation abwarten
	is_attacking = false
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Kill"):
		die()
	if Input.is_action_just_pressed("attack"):
		attack()
		
	else:
		get_input()
		move_and_slide()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if is_attacking:
		is_attacking = false


func _on_deathzone_body_entered(body: Node2D) -> void:
	pass # Replace with function body.




func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_enter_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
