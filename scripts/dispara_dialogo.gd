extends Area3D

var Dialogo = load("res://Scenes/UI/dialogo.tscn")
@export var nombre:= "Narrador"
@export var textos: Array[Resource] = []
@export var One_shot: bool
var sin_uso:= true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_body_entered(objeto):
	
	if !Global.interactuando and objeto.is_in_group("Player") and sin_uso:
		if One_shot:
			sin_uso = false
		var dialogo = Dialogo.instantiate()
		dialogo.nombre = nombre
		dialogo.textos = textos
		add_child(dialogo)
		dialogo.iniciar_dialogo()
