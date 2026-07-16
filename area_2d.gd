extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	monitoring = false  # am Anfang deaktiviert

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_hit"):
		body.get_hit()

func activate() -> void:
	monitoring = true

func deactivate() -> void:
	monitoring = false
