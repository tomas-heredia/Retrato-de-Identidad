extends objeto_interactuable
class_name cristo
@export var achilata : Mesh
var ya_penso = false

func cambio():
	set_mesh_dinamico(achilata)


func _on_pensamiento_body_entered(objeto):
	if objeto.is_in_group("Player") and !ya_penso:
		ya_penso= true
		Mensajero.Crear_pensamiento.emit("Mmm, ¿Qué es esto?\nJuro haberlo visto antes...\npero nunca tan pequeño")
