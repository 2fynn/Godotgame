extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("attack"):
		print("attack: ", body.name)
		body.slowdown()
		get_parent().hit()
		await get_tree().create_timer(0.7).timeout
		body.die()
