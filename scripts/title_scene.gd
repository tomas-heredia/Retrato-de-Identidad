extends Control

var SF_ON := preload("res://Assets/UI/Title_scene/SFX ON.PNG.png")
var SF_OFF := preload("res://Assets/UI/Title_scene/SFX OFF.png")
var MUSIC_ON := preload("res://Assets/UI/Title_scene/MUSIC-ON.PNG.png")
var MUSIC_OFF := preload("res://Assets/UI/Title_scene/MUSIC-OFF.PNG.png")

@onready var sfx = $SFX
@onready var music = $Music
@onready var salir = $Salir



func _ready() -> void:
	Guardado.load_game()


func _on_jugar_pressed():
	ManejoNiveles.cambiar("level_hub_world")


func _on_opciones_pressed():
	pass


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
