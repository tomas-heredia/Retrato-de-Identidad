extends Node

var pensamiento = load("res://Scenes/UI/pensamiento.tscn")


	
func Crear_pensamiento(Texto : String):
	var nuevoPensamiento = pensamiento.instantiate()
	add_child(nuevoPensamiento)
	nuevoPensamiento.Crear_pensamieto(Texto)
