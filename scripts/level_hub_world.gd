extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.interactuando = true
	Mensajero.Crear_pensamiento.emit("¿Qué pasó?\n¿Dónde estoy?\nNo recuerdo nada…")
	await get_tree().create_timer(5).timeout
	Global.interactuando = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
