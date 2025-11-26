extends MeshInstance3D

@onready var audio_stream_player_3d = $AudioStreamPlayer3D
@export var a_nivel :String = "level_hub_world"
@export var musica: AudioStreamWAV
# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player_3d.stream = musica
	audio_stream_player_3d.play()




func _on_area_3d_body_entered(objeto):
	if objeto.is_in_group("Player") and Global.puede_continuar:
		ManejoNiveles.cambiar(a_nivel)
