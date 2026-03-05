extends objeto_interactuable
class_name cristo
@export var achilata : Mesh
var ya_penso = false
@onready var animation_player: AnimationPlayer = $Pensamiento/AnimationPlayer


		

func cambio():
	Mensajero.Crear_pensamiento.emit("Mmm, ¿Qué es esto?\nJuro haberlo visto antes...\npero nunca tan pequeño")
	await get_tree().create_timer(5).timeout
	animation_player.play("Cambio")
	Mensajero.Crear_pensamiento.emit("!!!")
	interactuado = true


func cambiar_achilata():
		set_mesh_dinamico(achilata)

func _on_pensamiento_body_entered(objeto):
	if objeto.is_in_group("Player") and !ya_penso:
		ya_penso= true
		#Mensajero.Crear_pensamiento.emit("Mmm, ¿Qué es esto?\nJuro haberlo visto antes...\npero nunca tan pequeño")
