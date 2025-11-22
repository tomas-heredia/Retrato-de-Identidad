extends Control
@onready var recolectables = $recolectables/cantidad
var recolectados := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	recolectables.text = "0/5"
	Mensajero.connect("recolectable", aumentar_recolectable)
	

func aumentar_recolectable():
	recolectados += 1
	recolectables.text = str(recolectados) + "/5"
	if recolectados >= 5:
		Global.puede_continuar = true
