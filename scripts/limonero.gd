extends objeto_interactuable
@onready var animacion: AnimationPlayer = $animacion
@onready var limon: RigidBody3D = $Cuerpo/Limon

func cambio():
	
	animacion.play("sacudida")
	interactuado = true


func _on_animacion_animation_finished(anim_name: StringName) -> void:
	limon.gravity_scale = 9.8
	await get_tree().create_timer(1).timeout
	limon.queue_free()
