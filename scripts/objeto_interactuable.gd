extends StaticBody3D
@onready var label_3d = $Label3D
@onready var contorno = $MeshInstance3D/Contorno
@export var Texto := ""
var interactuable := false
@onready var camera_3d = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	label_3d.hide()
	contorno.hide()
	if Texto != "":
		label_3d.text = Texto


func _unhandled_input(event):
	if interactuable:
		if  event.is_action_pressed("Interact") and ! Global.interactuando:
			Global.interactuando = true
			label_3d.show()
			Mensajero.Cambio_Camara.emit(camera_3d)
		else:
			if event.is_action_pressed("Interact") and  Global.interactuando:
				
				Mensajero.regresar_camara.emit()
				label_3d.hide()
				

func _on_area_3d_body_entered(objeto):
	if objeto.is_in_group("Player"):
		contorno.show()
		interactuable = true


func _on_area_3d_body_exited(objeto):
	if objeto.is_in_group("Player"):
		contorno.hide()
		interactuable = false
