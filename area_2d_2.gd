extends Area2D

var follow_player :bool

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	print("entered")
	follow_player = true
