extends Area3D
@onready var pantalla: Control = $Pantalla


func _ready() -> void:
	pantalla.hide()

func _on_body_entered(objeto: Node3D) -> void:
	if objeto.is_in_group("Player") :
		pantalla.show()
		Global.interactuando = true
