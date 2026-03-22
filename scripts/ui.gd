extends Control
@onready var recolectables = $recolectables/cantidad
var recolectados := 0
@onready var menu_pausa: Control = $menu_pausa
@onready var fader: ColorRect = $Fader


var tiempo_fade := 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	Mensajero.connect("Muerte",fade_Out)
	fader.hide()
	get_tree().paused = false
	recolectables.text = "0/5"
	Mensajero.connect("recolectable", aumentar_recolectable)
	

func aumentar_recolectable():
	recolectados += 1
	recolectables.text = str(recolectados) + "/5"
	if recolectados >= 5:
		Global.puede_continuar = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa") and !menu_pausa.pausado:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		menu_pausa.pausado = !menu_pausa.pausado
		get_tree().paused = true
		menu_pausa.desplegar()

func fade_Out():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	fader.modulate.a = 0.0
	fader.show()
	
	
	
	# 2. Primera fase: Aparecer (Fade In)
	tween.tween_property(fader, "modulate:a", 1.0, tiempo_fade)
	
	tween.tween_callback(func(): Mensajero.Reaparecer.emit())
	tween.tween_interval(0.5) 
	tween.tween_property(fader, "modulate:a", 0.0, tiempo_fade)
	tween.tween_callback(fader.hide)
