extends MeshInstance3D
@onready var interaccion_label = $Interaccion_label
@onready var contorno = $Contorno
@onready var audio_player = $AudioStreamPlayer
@onready var animation_player = $AnimationPlayer
@onready var cielo_razo = $Cielo_razo

var interactuable := false
var interactuado := false
# Called when the node enters the scene tree for the first time.
func _ready():
	cielo_razo.hide()
	contorno.hide()

func _unhandled_input(event):
	if interactuable:
		if  event.is_action_pressed("Interact") and ! Global.interactuando:
			
			audio_player.play()
			interaccion_label.hide()
			Global.interactuando = true
			interactuable= false
			interactuado = true
			animation_player.play("Caida")

func _on_area_3d_body_entered(objeto):
	if objeto.is_in_group("Player") and !interactuado:
		interaccion_label.show()
		contorno.show()
		interactuable = true


func _on_area_3d_body_exited(objeto):
	if objeto.is_in_group("Player") and !interactuado:
		contorno.hide()
		interactuable = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Caida":
		contorno.hide()
		Global.interactuando = false
		Mensajero.Crear_pensamiento.emit("Eso estuvo cerca… Casi me mata")
