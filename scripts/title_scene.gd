extends Control

var SF_ON := preload("res://Assets/UI/Title_scene/SFX ON.PNG.png")
var SF_OFF := preload("res://Assets/UI/Title_scene/SFX OFF.png")
var MUSIC_ON := preload("res://Assets/UI/Title_scene/MUSIC-ON.PNG.png")
var MUSIC_OFF := preload("res://Assets/UI/Title_scene/MUSIC-OFF.PNG.png")

@onready var sfx = $SFX
@onready var music = $Music
@onready var salir = $Salir
@onready var confirmacion: Control = $Confirmacion
@onready var jugar: Button = $Jugar
@onready var controles_display: Control = $Controles_display
@onready var nuevo_juego: Button = $Nuevo_juego
@onready var volver_controles: Button = $Controles_display/Volver
@onready var no_confirmar: Button = $Confirmacion/No



func _ready() -> void:
	Guardado.load_game()
	confirmacion.hide()
	controles_display.hide()
	if !Guardado.existe_guardado():
		nuevo_juego.grab_focus()
		jugar.disabled =true
	else:
		jugar.grab_focus()

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("Interact"): # o la acción que quieras
		#var focused = get_viewport().gui_get_focus_owner()
		#if focused and focused is Button:
			#focused.press()

func _on_jugar_pressed():
	
	ManejoNiveles.cambiar(Guardado.game_data.level_actual)


func _on_controles_pressed() -> void:
	controles_display.show()
	volver_controles.grab_focus()

func _on_creditos_pressed():
	pass # Replace with function body.


func _on_sfx_pressed():
	if (sfx.icon == SF_ON):
		sfx.icon = SF_OFF
	else:
		sfx.icon = SF_ON


func _on_music_pressed():
	if (music.icon == MUSIC_ON):
		music.icon = MUSIC_OFF
	else:
		music.icon = MUSIC_ON


func _on_salir_pressed():
	get_tree().quit()


func _on_nuevo_juego_pressed() -> void:
	if Guardado.existe_guardado():
		confirmacion.show()
		no_confirmar.grab_focus()
		for boton in [$Jugar, $Nuevo_juego, $Controles, $Creditos, $SFX, $Music, $Salir]:
			boton.disabled = true

	else:
		Guardado.sobreescribir()
		ManejoNiveles.cambiar("level_hub_world")


func _on_si_pressed() -> void:
	Guardado.sobreescribir()
	ManejoNiveles.cambiar("level_hub_world")


func _on_no_pressed() -> void:
	confirmacion.hide()
	for boton in [$Jugar, $Nuevo_juego, $Controles, $Creditos, $SFX, $Music, $Salir]:
			boton.disabled = false
	if !Guardado.existe_guardado():
		jugar.disabled =true
	else:
		jugar.grab_focus()


func _on_volver_pressed() -> void:
	controles_display.hide()
	if !Guardado.existe_guardado():
		nuevo_juego.grab_focus()
	else:
		jugar.grab_focus()
