extends Area2D

func _ready() -> void:
	body_entered.connect(_on_area_2d_body_entered)

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Body entered: ", body.name)
	get_parent().death()
		
		# Spieler abfedern lassen (kleiner Sprung nach oben)
	if body.has_method("bounce"):
		body.bounce()
