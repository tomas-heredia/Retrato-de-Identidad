extends Control
@onready var confirmacion: Control = $Confirmacion
@onready var label: Label = $Confirmacion/Label
var SF_ON := preload("res://Assets/UI/Title_scene/SFX ON.PNG.png")
var SF_OFF := preload("res://Assets/UI/Title_scene/SFX OFF.png")
var MUSIC_ON := preload("res://Assets/UI/Title_scene/MUSIC-ON.PNG.png")
var MUSIC_OFF := preload("res://Assets/UI/Title_scene/MUSIC-OFF.PNG.png")
@onready var volver: Button = $Volver
var bus_musica = AudioServer.get_bus_index("Musica")
var bus_efectos = AudioServer.get_bus_index("Efectos")
@onready var no: Button = $Confirmacion/No

@onready var sfx = $SFX
@onready var music = $Music
@onready var salir = $Salir
var reiniciar := false
var pausado := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	if Guardado.game_data.valor_musica == 0:
		AudioServer.set_bus_mute(bus_efectos, true)
		music.icon = MUSIC_OFF
	else:
		AudioServer.set_bus_mute(bus_efectos, false)
		music.icon = MUSIC_ON
	
	if Guardado.game_data.valor_efectos == 0:
		AudioServer.set_bus_mute(bus_musica, true)
		sfx.icon = SF_OFF
	else:
		AudioServer.set_bus_mute(bus_musica, false)
		sfx.icon = SF_ON


func desplegar():
	show()
	volver.grab_focus()



func _on_volver_pressed() -> void:
	hide()
	volver.release_focus()
	pausado = !pausado
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_reiniciar_pressed() -> void:
	
	confirmacion.show()
	no.grab_focus()
	label.text = "¿Reiniciar partida?"
	reiniciar = true
	for boton in [$Volver, $Reiniciar, $"Menu Principal"]:
		boton.disabled = true


func _on_menu_principal_pressed() -> void:
	confirmacion.show()
	label.text = "¿Salir al Menu?"
	for boton in [$Volver, $Reiniciar, $"Menu Principal"]:
		boton.disabled = true


func _on_si_pressed() -> void:
	
	if reiniciar:
		ManejoNiveles.recargar()
	else: 
		get_tree().paused = false
		await get_tree().process_frame
		ManejoNiveles.cambiar("title_scene")


func _on_no_pressed() -> void:
	confirmacion.hide()
	reiniciar = false
	volver.grab_focus()
	for boton in [$Volver, $Reiniciar, $"Menu Principal"]:
		boton.disabled = false


func _on_sfx_pressed() -> void:
	if (sfx.icon == SF_ON):
		AudioServer.set_bus_mute(bus_efectos, true)
		Guardado.game_data.valor_efectos = 0
		
		sfx.icon = SF_OFF
	else:
		AudioServer.set_bus_mute(bus_efectos, false)
		Guardado.game_data.valor_efectos = 100
		sfx.icon = SF_ON


func _on_music_pressed() -> void:
	if (music.icon == MUSIC_ON):
		AudioServer.set_bus_mute(bus_musica, true)
		Guardado.game_data.valor_musica = 0
		music.icon = MUSIC_OFF
	else:
		AudioServer.set_bus_mute(bus_musica, false)
		Guardado.game_data.valor_musica = 100
		music.icon = MUSIC_ON


func _on_salir_pressed() -> void:
	get_tree().quit()
