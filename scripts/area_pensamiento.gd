extends Area3D
@export var pensamiento : String = ""
var usado := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(objeto: Node3D) -> void:
	if !usado and objeto.is_in_group("Player"):
		usado = true
		Mensajero.Crear_pensamiento.emit(pensamiento)
