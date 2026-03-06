extends Control
@onready var recolectables = $recolectables/cantidad
var recolectados := 0
@onready var menu_pausa: Control = $menu_pausa

# Called when the node enters the scene tree for the first time.
func _ready():
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
		menu_pausa.show()
