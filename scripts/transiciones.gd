extends Control
signal termina
signal iniciar
@export var inicio: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	ManejoNiveles.connect("fadeOut",FadeOut)
	
	$AnimationPlayer.play("FadeIn")
	
func FadeOut():
	
	$AnimationPlayer.play("FadeOut")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "FadeOut":
		emit_signal("termina")
	else:
		emit_signal("iniciar")
		
