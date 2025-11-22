extends Area3D

@onready var animation_player = $cuerpo/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("flotar")



func _on_body_entered(objeto):
	if objeto.is_in_group("Player"):
		Mensajero.recolectable.emit()
		self.queue_free()
