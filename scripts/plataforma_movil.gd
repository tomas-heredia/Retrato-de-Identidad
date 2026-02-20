extends AnimatableBody3D
@export var altura_max : int
@export var altura_min : int
@export var velocidad : int

func _ready() -> void:
	mover_altura_loop()

func mover_altura_loop():
	var distancia = abs(altura_min - altura_max)
	var duracion = distancia / velocidad

	var tween := create_tween()
	tween.set_loops()

	tween.tween_property(self, "position:y", altura_min, duracion)
	tween.tween_property(self, "position:y", altura_max, duracion)
	
	if position.y == altura_min:
		mover_altura_loop()
