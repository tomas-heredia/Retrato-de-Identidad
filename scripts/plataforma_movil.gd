extends AnimatableBody3D
@export var altura_max : int
@export var altura_min : int
@export var velocidad : int
@export var tiempo_espera : float
func _ready() -> void:
	mover_altura_loop()

func mover_altura_loop():
	while true:
		# Mover hacia altura_min
		await mover_hasta(altura_min)
		await get_tree().create_timer(tiempo_espera).timeout

		# Mover hacia altura_max
		await mover_hasta(altura_max)
		await get_tree().create_timer(tiempo_espera).timeout



func mover_hasta(objetivo_y: float) -> void:
	var distancia = abs(position.y - objetivo_y)
	var duracion = distancia / velocidad
	
	var tween := create_tween()
	tween.tween_property(self, "position:y", objetivo_y, duracion)
	
	await tween.finished
