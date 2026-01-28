extends Area3D



func _on_body_entered(objeto):
	if objeto.is_in_group("Player"):
		objeto.recibir_daño(100)
