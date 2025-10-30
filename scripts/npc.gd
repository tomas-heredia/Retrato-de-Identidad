extends StaticBody3D

@onready var contorno = $Cuerpo/Contorno
@export var nombre:= "Tomás"
@export var textos: Array[Resource] = []

var Dialogo = load("res://Scenes/UI/dialogo.tscn")
var interactuable: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	contorno.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_body_entered(objeto):
	if objeto.is_in_group("Player"):
		interactuable = true
		contorno.show()


func _on_area_body_exited(objeto):
	if objeto.is_in_group("Player"):
		interactuable = false
		contorno.hide()

func _unhandled_input(event):
	if interactuable and event.is_action_pressed("Interact") and ! Global.interactuando:
		var dialogo = Dialogo.instantiate()
		dialogo.nombre = nombre
		dialogo.textos = textos
		add_child(dialogo)
		dialogo.iniciar_dialogo()
		
