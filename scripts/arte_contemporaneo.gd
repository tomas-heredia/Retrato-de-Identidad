extends objeto

@export var modelo_nuevo :Mesh
# Called when the node enters the scene tree for the first time.
func cambio():
	set_mesh_dinamico(modelo_nuevo)
	Global.interactuando = false
	Mensajero.Crear_pensamiento.emit("Ehh… esto ya estaba así, ¿no?")
