extends Area3D

var usado: bool = false



func _on_body_entered(objeto):
	if objeto.is_in_group("Player") and !usado:
		usado = true
		
		Global.ultimoCheckPoint = position
		Guardado.game_data["checkpoints"][Global.nivel_actual] = position
		Guardado.save_game()
