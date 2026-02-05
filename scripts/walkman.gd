extends objeto_interactuable
class_name walkman
var interacciones := 0
@onready var efecto_boton: AudioStreamPlayer = $EfectoBoton
@onready var musica: AudioStreamPlayer3D = $Musica

@export var cancion1 : AudioStream
@export var cancion2 : AudioStream
@export var cancion3 : AudioStream

func _ready():
	super._ready()
	efecto_boton.stream = efecto
func cambio():
	efecto_boton.play()
	interacciones += 1
	if interacciones <= 3:
		match interacciones :
			1:
				musica.stream = cancion1
			2:
				musica.stream = cancion2
			3:
				musica.stream = cancion3
		await efecto_boton.finished
		musica.play()
	else:
		musica.stop()
	
	mas_interacciones()
	
func mas_interacciones():
	if interacciones <= 3:
		interactuado = false
	else:
		interactuado = true
