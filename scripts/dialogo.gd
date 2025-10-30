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
	hide()
	text_box.text = ""

func iniciar_dialogo():
	show()
	Global.interactuando = true
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
		"Salida":
			Global.interactuando = false
			self.queue_free()

func show_text(text: String) -> void:
	stop_text = false
	text = text.replace("\\n", "\n")

	# comienzo el timer, suponiendo que no es un oneshot
	espera_letra.start()

	for i in text.length():
		if stop_text:
			break
		
		text_box.text += text[i]
		await espera_letra.timeout

 
func _show_next_dialogo():
	if dialogo_actual < cant_dialogos:
		stop_text = true  # detener cualquier texto anterior
		# detengo el timer y emito timeout, asi el bucle for en show_text continua. como stop_text es true, deberia hacer break
		espera_letra.stop()
		espera_letra.timeout.emit()

		#espero un frame por las dudas (probar si es necesario o no)
		await get_tree().process_frame

		text_box.text = ""
		show_text(textos[dialogo_actual].texto)
		dialogo_actual += 1
		print(dialogo_actual)
		espera.start()
		saltable = false
		omitir.hide()
	

func _on_espera_timeout():
	omitir.show()
	saltable = true
	print("omitible")

func _unhandled_input(event):
	if event.is_action_pressed("pasar_dialogo") :
		if saltable and dialogo_actual< cant_dialogos:
			
			_show_next_dialogo()
		elif saltable and dialogo_actual >= cant_dialogos:
			
			fin_fialogo()
			
	
func fin_fialogo():
	animation_player.play("Salida")
	stop_text = true  # detener cualquier texto anterior
	# detengo el timer y emito timeout, asi el bucle for en show_text continua. como stop_text es true, deberia hacer break
	espera_letra.stop()
	espera_letra.timeout.emit()

	#espero un frame por las dudas (probar si es necesario o no)
	await get_tree().process_frame

	text_box.text = ""
	
	#dialogo_actual += 1
	#print(dialogo_actual)
	#espera.start()
	saltable = false
	omitir.hide()
	dialogo_actual = 0
