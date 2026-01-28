extends objeto_interactuable
class_name vasija
@export var vasija_rota : Mesh

func cambio():
	set_mesh_dinamico(vasija_rota)
