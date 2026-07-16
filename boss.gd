extends CharacterBody2D
#code für denn boss

@onready var enemy = $CharacterBody2D2
@onready var _animated_enemy_sprite = $AnimatedEnemySprite2D
@onready var player = get_node("../CharacterBody2D")
var speed = 10
var max_health: int = 50
var health: int = max_health
var died: bool = false
const JUMP_VELOCITY = -100.0
var in_attack = false

var follow_player :bool 

func play_animation(name):
	_animated_enemy_sprite.play(name)


func _physics_process(delta: float) :
	if in_attack:
		return 
	if follow_player:
		if !died:
			var player_pos = player.global_position
			var enemy_pos = global_position
			if player == null:
				print("playernichtgefunden")
				return
			var direction = (player_pos - enemy_pos).normalized()
			velocity = direction * speed
			if direction.x > 0:
				$AnimatedEnemySprite2D.flip_h = true
			elif direction.x < 0:
				$AnimatedEnemySprite2D.flip_h = false
			if not is_on_floor():
				velocity += get_gravity() * delta
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
			move_and_slide()
			if velocity.x==0:
				play_animation("idle")
			else: 
				play_animation("walk")
			move_and_slide()
		else:
			return

func activate():
	follow_player = true

func hit():
	in_attack = true
	play_animation("hit")
	await get_tree().create_timer(1).timeout #normaler timer
	_animated_enemy_sprite.stop()
	in_attack = false
func boss():
	pass
func get_hit():
	health-=10
	in_attack = true
	play_animation("take_damage")
	await get_tree().create_timer(1).timeout #normaler timer
	_animated_enemy_sprite.stop()
	in_attack = false
	if health<=0:
		death()
		return
	

func get_damage():
	pass

func death():
	if died:
		return
	died = true
	velocity = Vector2.ZERO #dadurch kann er sich nicht mehr bewegen
	set_physics_process(false)
	play_animation("die")
	set_collision_layer(0)
	set_collision_mask(0)
	await get_tree().create_timer(1.5).timeout
	queue_free()  #removed ihn komplett in der szene(node wird während dem spiel gelöscht)
	
func _on_area_2d_body_entered(area: Area2D) -> void:
	death()
