extends Area2D
#attack hitbox vom spieler
func _ready() -> void:
	body_entered.connect(_on_attackarea_body_entered)
	monitoring = false  # am Anfang deaktiviert

func _on_attackarea_body_entered(body: Node2D) -> void:
	if body.has_method("get_hit"):
		body.get_hit() #ruft den body der die attackzone betreten hat auf und führt dort func. hit durch

func activate():
	monitoring = true  #monitoring true/false ist um die hitbox vom schwert nur während des angriffs abspielen zu lassen

func deactivate():
	monitoring = false
