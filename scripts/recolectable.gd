extends Area3D

@export var RigidBody_relacionados: Array[RigidBody3D] = []
@onready var animation_player = $cuerpo/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("flotar")



func _on_body_entered(objeto):
	if objeto.is_in_group("Player"):

		for elemento in RigidBody_relacionados:
			if elemento.is_in_group("plataforma_invisible"):
				elemento.activar()

		Mensajero.recolectable.emit()
		self.queue_free()
