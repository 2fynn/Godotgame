extends Area2D
#das ist damit die enemies erst laufen wenn der spieler ihre area betritt
func _ready() -> void:
	body_entered.connect(_on_body_entered)   #sehr wichtig sonst funktioniert es nicht

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("attack"):  #um zu überporüfen ob es der player ist und nicht er selbst
		print("Body entered: ", body.name)
		get_parent().activate() #die area ist ein child vom enemy(characterbody2D2/3) also können über parent func aufgerufen werden
