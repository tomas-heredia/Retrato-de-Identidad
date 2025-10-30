extends Control
@onready var text_box = $Caja/text_box

@onready var espera = $Espera
@onready var omitir = $Caja/Omitir
@onready var espera_letra = $Espera_letra

@onready var label_nombre = $Caja/Nombre/Label

@export var nombre:= "Tomás"
@export var textos: Array[Resource] = []
var full_text := "Este texto es demasiado largo y \ncontiene palabras como \ndesoxirribonucleico que deben \najustarse antes de mostrarse."
@onready var animation_player = $AnimationPlayer
@export var text_speed := 0.02
var cant_dialogos := 0
var dialogo_actual := 0
var saltable := false
# Aquí guardamos la tarea actual de show_text
var stop_text := false

func _ready():
	cant_dialogos = textos.size()
	label_nombre = nombre
	animation_player.play("Intro")



func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Intro":
			text_box.text = ""
			show_text(textos[dialogo_actual].texto)
			dialogo_actual += 1
			espera.start()

func show_text(text: String) -> void:
	stop_text = false
	text = text.replace("\\n", "\n")
	
	for i in text.length():
		if stop_text:
			
			break
		text_box.text += text[i]
		espera_letra.start()
		await espera_letra.timeout
	#text_box.text = text  # asegura que el texto completo se muestre si se interrumpió


func _on_espera_timeout():
	omitir.show()
	saltable = true

func _unhandled_input(event):
	if event.is_action_pressed("pasar_dialogo") and saltable and dialogo_actual< cant_dialogos:
		_show_next_dialogo()

func _show_next_dialogo():
	if dialogo_actual < cant_dialogos:
		stop_text = true  # detener cualquier texto anterior
		text_box.text = ""
		espera_letra.stop()
		show_text(textos[dialogo_actual].texto)
		dialogo_actual += 1
		espera.start()
		saltable = false
