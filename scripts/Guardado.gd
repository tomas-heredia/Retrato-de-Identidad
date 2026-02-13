extends Node


var save_path :=  "res://Guardado/save_game.dat" if OS.has_feature("editor") else "user://save_game.dat"


var game_data : Dictionary= {
	"hub_visitado" : false,
	"level_1_visitado" : false
	
}

#aqui debemos agregar los campos nuevos
var default_data : Dictionary= {
	"hub_visitado" : false,
	"level_1_visitado" : false
#NOTAAA!!!! siempre que agregues algo al defalut data, agregrarlo en la func sobreescribir
}


func _ready():
	#if OS.has_feature("editor"):
		#print("editor")
		#
	#else:
		#print("no editor")
		#
	pass

func save_game() -> void:
	var save_file = FileAccess.open(save_path,FileAccess.WRITE)
	
	save_file.store_var(game_data)
	save_file = null

#aqui se agregan los campos nuevos al archivo viejo, evitando tener que borrarlo
func load_game() -> void: 
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		var loaded_data = save_file.get_var()
		save_file = null
		# Mezcla loaded_data con default_data
		for key in default_data:
			if not loaded_data.has(key):
				loaded_data[key] = default_data[key]
		
		
			
			
		game_data = loaded_data

func existe_guardado():

	if FileAccess.file_exists(save_path):
		return true
	else:
		return false
