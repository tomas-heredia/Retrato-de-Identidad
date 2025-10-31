extends StaticBody3D

@onready var audio_stream_player_3d = $AudioStreamPlayer3D

@export var musica: AudioStreamWAV
# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player_3d.stream = musica
	audio_stream_player_3d.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
