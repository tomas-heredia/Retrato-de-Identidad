extends Node3D

@onready var player: CharacterBody3D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Guardado.save_game()
	if Guardado.game_data["checkpoints"]["level_1"] != Vector3.ZERO:
		player.position =  Guardado.game_data["checkpoints"]["level_1"]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
