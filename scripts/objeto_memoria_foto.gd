extends Area3D

var Dialogo = load("res://Scenes/UI/dialogo.tscn")
@export var nombre:= "Narrador"
@export var textos: Array[Resource] = []

@export var imagen : Texture2D

@onready var animation_player = $cuerpo/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("flotar")
	


func _on_body_entered(objeto):
	if objeto.is_in_group("Player"):
		var dialogo = Dialogo.instantiate()
		dialogo.imagen = imagen
		dialogo.nombre = nombre
		dialogo.textos = textos
	
		get_tree().root.add_child(dialogo)
		dialogo.iniciar_dialogo()

		Mensajero.recolectable.emit()
		self.queue_free()

func recolectado():
	self.hide()
	$CollisionShape3D.disabled = true
	Mensajero.recolectable.emit()
