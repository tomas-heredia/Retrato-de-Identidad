extends StaticBody3D
@onready var label_3d = $Label3D
@onready var contorno = $MeshInstance3D/Contorno
@export var Texto := ""
var interactuable := false
@onready var camera_3d = $Camera3D
var interactuado := false
@onready var interaccion_label = $Interaccion_label
@onready var cuerpo = $Cuerpo

# Called when the node enters the scene tree for the first time.
func _ready():
	interaccion_label.hide()
	label_3d.hide()
	contorno.hide()
	if Texto != "":
		label_3d.text = Texto


func _unhandled_input(event):
	if interactuable:
		if  event.is_action_pressed("Interact") and ! Global.interactuando:
			interaccion_label.hide()
			Global.interactuando = true
			label_3d.show()
			Mensajero.Cambio_Camara.emit(camera_3d)
			interactuado = true
		else:
			if event.is_action_pressed("Interact") and  Global.interactuando:
				
				Mensajero.regresar_camara.emit()
				label_3d.hide()
				

func _on_area_3d_body_entered(objeto):
	if objeto.is_in_group("Player") and !interactuado:
		interaccion_label.show()
		contorno.show()
		interactuable = true


func _on_area_3d_body_exited(objeto):
	if objeto.is_in_group("Player"):
		contorno.hide()
		interactuable = false
