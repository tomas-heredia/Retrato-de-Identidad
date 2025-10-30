extends StaticBody3D

@onready var contorno = $Cuerpo/Contorno
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
