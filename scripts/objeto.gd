
extends MeshInstance3D
class_name objeto
@onready var interaccion_label = $Interaccion_label
@onready var contorno = $Contorno
@onready var audio_player = $AudioStreamPlayer

@export var modelo : Mesh
var interactuable := false
var interactuado := false
# Called when the node enters the scene tree for the first time.
func _ready():
	inicio()
	interaccion_label.hide()
	set_mesh_dinamico(modelo)
	contorno.hide()

func inicio():
	pass
	
func _unhandled_input(event):
	if interactuable:
		if  event.is_action_pressed("Interact") and ! Global.interactuando:
			
			audio_player.play()
			interaccion_label.hide()
			Global.interactuando = true
			interactuable= false
			interactuado = true
			cambio()
	

func _on_area_3d_body_entered(objeto):
	if objeto.is_in_group("Player") and !interactuado:
		interaccion_label.show()
		contorno.show()
		interactuable = true


func _on_area_3d_body_exited(objeto):
	if objeto.is_in_group("Player") and !interactuado:
		contorno.hide()
		interactuable = false

func set_mesh_dinamico(new_mesh: Mesh):
	# Asigna el mesh al cuerpo
	self.mesh = new_mesh

	# Asigna el mismo mesh al contorno
	contorno.mesh = new_mesh

	# Aplica el material de contorno
	
	contorno.material_override = load("res://Assets/Materiales/Contornos/contorno_objeto_interactuable.tres")
	#contorno.material_override = outline_mat

	# Escala suavemente hacia afuera para simular el contorno
	contorno.scale = Vector3(1.1, 1.1, 1.1)

func cambio():
	pass
