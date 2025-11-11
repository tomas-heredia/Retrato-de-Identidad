extends StaticBody3D
@onready var label_3d = $Label3D
@onready var label = $Label

@export var texto: String

var interactuable := false
# Called when the node enters the scene tree for the first time.
func _ready():
	label_3d.text = texto
	label.hide()
	label_3d.hide()


func _unhandled_input(event):
	if interactuable and event.is_action_pressed("Interact"):
		mostrar_Texto()


func mostrar_Texto():
	label_3d.show()


func _on_area_3d_body_entered(objeto):
	if objeto.is_in_group("Player"):
		label.show()
		interactuable = true


func _on_area_3d_body_exited(objeto):
	if objeto.is_in_group("Player"):
		interactuable = false
		label.hide()
		label_3d.hide()
