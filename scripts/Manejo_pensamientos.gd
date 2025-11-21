extends Node

var pensamiento = load("res://Scenes/UI/pensamiento.tscn")

func _ready():
	Mensajero.connect("Crear_pensamiento",Crear_pensamiento)

	
func Crear_pensamiento(Texto : String):
	var nuevoPensamiento = pensamiento.instantiate()
	add_child(nuevoPensamiento)
	nuevoPensamiento.Crear_pensamieto(Texto)
