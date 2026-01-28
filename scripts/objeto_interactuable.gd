extends StaticBody3D
class_name objeto_interactuable
@export var Texto := ""
@export var modelo : Mesh
@export var efecto : AudioStream
@onready var label_3d = $Label3D
@onready var contorno = $Cuerpo/Contorno
@onready var cuerpo = $Cuerpo
var interactuable := false
@onready var camera_3d = $Camera3D
var interactuado := false
@onready var interaccion_label = $Interaccion_label
@onready var audio_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if audio_player:
		audio_player.stream = efecto
	set_mesh_dinamico(modelo)
	interaccion_label.hide()
	label_3d.hide()
	contorno.hide()
	if Texto != "":
		label_3d.text = Texto


func _unhandled_input(event):
	if interactuable:
		if  event.is_action_pressed("Interact") and ! Global.interactuando:
			cambio()
			audio_player.play()
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

func set_mesh_dinamico(new_mesh: Mesh):
	# Asigna el mesh al cuerpo
	cuerpo.mesh = new_mesh

	# Asigna el mismo mesh al contorno
	contorno.mesh = new_mesh

	# Aplica el material de contorno
	
	contorno.material_override = load("res://Assets/Materiales/Contornos/contorno_objeto_interactuable.tres")
	#contorno.material_override = outline_mat

	# Escala suavemente hacia afuera para simular el contorno
	contorno.scale = Vector3(1.1, 1.1, 1.1)

func cambio():
	pass
