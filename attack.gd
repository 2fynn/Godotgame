extends Area2D
#attack für die mushrooms
#sobald der player in ihrer attack area ist greifen sie an
#unter den enemy characterbody (area: name attackhitbox)
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("attack"):
		print("attack: ", body.name)
		body.slowdown()
		if get_parent().has_method("boss"):
			body.bossattacked()
		get_parent().hit()
		await get_tree().create_timer(0.7).timeout
		body.get_hit()
		
