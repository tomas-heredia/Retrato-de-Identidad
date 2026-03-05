extends objeto_interactuable
class_name walkman
var indice_cancion := 0
@onready var efecto_boton: AudioStreamPlayer = $EfectoBoton
@onready var musica: AudioStreamPlayer3D = $Musica
@onready var Cambio_label: Label = $Interaccion_label2
@onready var Salir_label: Label = $Interaccion_label3
var listo := false
var en_walkman = false
@export var canciones: Array[AudioStream]

func _ready():
	super._ready()
	efecto_boton.stream = efecto
func cambio():
	indice_cancion = 0
	en_walkman = true
	Cambio_label.show()
	efecto_boton.play()
	
	
	

func tocar_musica():
	efecto_boton.play()
	

	if canciones.size() == 0:
		push_error("No hay canciones asignadas al walkman")
		return

	musica.stream = canciones[indice_cancion]
	indice_cancion = (indice_cancion + 1) 

	musica.play()
func mas_interacciones():
	if  indice_cancion >= canciones.size():
	
		indice_cancion = 0
		Salir_label.show()
		listo = true
		
		

func _process(delta: float) -> void:
	if en_walkman:
		if Input.is_action_just_pressed("salir_walkman") and listo:
			
			Cambio_label.hide()
			Salir_label.hide()
			musica.stop()
			precionarE()
		if Input.is_action_just_pressed("Interact") :
			
			tocar_musica()
			mas_interacciones()

func precionarE():
	en_walkman = false
	interactuado = true
	await get_tree().process_frame  # Espera al siguiente frame
	var ev := InputEventAction.new()
	ev.action = "Interact"
	ev.pressed = true
	Input.parse_input_event(ev)
	await get_tree().process_frame  # Permite que se registre el "just_pressed"
	ev.pressed = false
	Input.parse_input_event(ev)
