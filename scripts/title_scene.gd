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



func _ready() -> void:
	Guardado.load_game()
	confirmacion.hide()
	controles_display.hide()
	if !Guardado.existe_guardado():
		jugar.disabled =true


func _on_jugar_pressed():
	
	ManejoNiveles.cambiar(Guardado.game_data.level_actual)


func _on_controles_pressed() -> void:
	controles_display.show()

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


func _on_volver_pressed() -> void:
	controles_display.hide()
