extends Area2D
#deathzone tötet spieler die sie betreten
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()  #ruft die methoden des players auf(body ist der der die area betreten hat
