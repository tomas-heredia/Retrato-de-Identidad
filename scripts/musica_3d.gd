extends AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(objeto: Node3D) -> void:
	if objeto.is_in_group("Player"):
		fade_out_musica()

func fade_out_musica(duracion: float = 2.0):
	
	var bus_index = AudioServer.get_bus_index("Musica")
	
	
	var tween = create_tween()
	
	tween.tween_method(
		func(valor): AudioServer.set_bus_volume_db(bus_index, valor),
		AudioServer.get_bus_volume_db(bus_index),-80.0,duracion)

func fade_in_musica(duracion: float = 2.0):
	var bus_index = AudioServer.get_bus_index("Musica")
	
	
	var tween = create_tween()
	
	tween.tween_method(
		func(valor): AudioServer.set_bus_volume_db(bus_index, valor),
		AudioServer.get_bus_volume_db(bus_index),0.0,duracion)


func _on_area_3d_body_exited(objeto: Node3D) -> void:
	if objeto.is_in_group("Player"):
		fade_in_musica()
