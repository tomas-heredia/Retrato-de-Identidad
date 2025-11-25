extends Node3D

var Dialogo = load("res://Scenes/UI/dialogo.tscn")
@export var nombre:= "Narrador"
@export var textos: Array[Resource] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.interactuando = true
	Mensajero.Crear_pensamiento.emit("¿Qué pasó?\n¿Dónde estoy?\nNo recuerdo nada…")
	await get_tree().create_timer(5).timeout
	
	var dialogo = Dialogo.instantiate()
	dialogo.nombre = nombre
	dialogo.textos = textos
	add_child(dialogo)
	dialogo.iniciar_dialogo()
