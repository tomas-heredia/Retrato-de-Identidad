extends Area3D




func _on_body_entered(objeto: Node3D) -> void:
	if objeto.is_in_group("Player") :
		Mensajero.fadeOut.emit()
		await get_tree().create_timer(2.0).timeout
		ManejoNiveles.cambiar("level_hub_world")
