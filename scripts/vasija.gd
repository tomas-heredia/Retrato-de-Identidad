extends objeto_interactuable
class_name vasija
@export var vasija_rota : Mesh

func cambio():
	set_mesh_dinamico(vasija_rota)
	Mensajero.Crear_pensamiento.emit("Eeeh… esto ya estaba así, ¿no? Mejor me voy.")
	interactuado = true
