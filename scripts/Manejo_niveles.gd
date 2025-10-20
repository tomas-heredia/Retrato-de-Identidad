extends Node
var niveles := {
	"level_test": preload("res://Scenes/Levels/level_test.tscn"),
	"level_test_2": preload("res://Scenes/Levels/level_test_2.tscn")
}
var proximo_nivel : String
func cambiar(nombre :String):
	var dir = nombre.to_lower() +'.tscn'
	
	if niveles.has(nombre):
		#Guardado.game_data.nivel_actual = nombre.to_lower()
		#Global.nivel_actual = nombre.to_lower()
		
		print(nombre)
		get_tree().change_scene_to_packed(niveles[nombre])
			
	else:
		print('El nivel al que quiere acceder no existe')
		print(nombre)
#var niveles := {
	#"menu_principal": preload("res://Scenes/Levels/menu_principal.tscn"),
	#"level_ensamblado": preload("res://Scenes/Levels/level_ensamblado.tscn"),
	#"level_entrevista": preload("res://Scenes/Levels/level_entrevista.tscn"),
	#"level_lobby": preload("res://Scenes/Levels/level_lobby.tscn"),
	#"level_oficina": preload("res://Scenes/Levels/level_oficina.tscn"),
	#"level_uqz": preload("res://Scenes/Levels/level_uqz.tscn"),
	#"level_3": preload("res://Scenes/Levels/level_3.tscn"),
	#"level_casaHistorica": preload("res://Scenes/Levels/level_casaHistorica.tscn"),
	#"level_archivos": preload("res://Scenes/Levels/level_archivos.tscn"),
	#"level_escuela": preload("res://Scenes/Levels/level_escuela.tscn"),
	#"level_confiteria": preload("res://Scenes/Levels/level_confiteria.tscn"),
	#"level_amaicha": preload("res://Scenes/Levels/level_amaicha.tscn"),
	#"tvc_splash_screen" : preload("res://Scenes/UI/TVC_Splash_Screen.tscn"),
	#"escena_apertura" : preload("res://Scenes/Levels/escena_apertura.tscn")
#}
#
#var proximo_nivel : String
#var nombre_titulo : String = "xxxx"
#
#func cambiar(nombre :String):
	#var dir = nombre.to_lower() +'.tscn'
	#
	#if niveles.has(nombre):
		#Guardado.game_data.nivel_actual = nombre.to_lower()
		#Global.nivel_actual = nombre.to_lower()
		#
		#print(nombre)
		#get_tree().change_scene_to_packed(niveles[nombre])
			#
	#else:
		#print('El nivel al que quiere acceder no existe')
		#print(nombre)
#
#func cambiar_transicion(nombre,titulo: String = "xxxx"):
	#proximo_nivel = nombre
	#nombre_titulo = titulo
	#Guardado.game_data.nivel_actual = nombre 
	#Mensajero.salir_a_nivel.emit(nombre)
#
#func cambiar_titulo( titulo: String = "xxxx"):
	#nombre_titulo = titulo
	#get_tree().change_scene_to_file("res://Scenes/UI/pantalla_titulos.tscn")
